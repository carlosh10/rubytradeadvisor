class Search::QueryBuilder

  include Search::SelectionFilterType
  include Search::RangeFilterType

  attr_accessor :struct, :pagination, :index_of

  def initialize
    self.struct = {
      body: { query: { filtered: { filter: { bool: { should: [], must: [] }}}},
              size: "36",
              from: "1",
              aggs: {
                cif: { sum: { field: :CIF } } ,
                Search::SelectionFilterType::Ncm => { terms: { field: :ncm}   },
                Search::SelectionFilterType::CountryOrigin => { terms: { field: :siglaPaisOrigem }   },
                Search::SelectionFilterType::CountryAquisition => { terms: { field: :siglaPaisAquisicao }   },
                Search::RangeFilterType::TotalValue => { max: { field: :CIF } },
                Search::RangeFilterType::UnityValue => { max: { field: :CIF_unitario } },
                Search::RangeFilterType::Quantity => { max: { field: :quantidade_comercializada_produto } },
                Search::RangeFilterType::Customs => { max: { field: :quantidade_aduaneira } }
              }
              }
    }

    # TODO refactor iterate over ao filter types and add to strutc to build_aggregations
    self.index_of =  {
      Search::SelectionFilterType::Ncm => :ncm,
      Search::SelectionFilterType::CountryOrigin  => :siglaPaisOrigem,
      Search::SelectionFilterType::CountryAquisition => :siglaPaisAquisicao,
      Search::RangeFilterType::TotalValue => :CIF,
      Search::RangeFilterType::UnityValue => :CIF_unitario,
      Search::RangeFilterType::Quantity => :quantidade_comercializada_produto,
      Search::RangeFilterType::Customs => :quantidade_aduaneira
    }

  end


  def build query, selection_filters = nil, range_filters = nil, pagination = nil
  	build_query(query)
    build_pagination(pagination)
    build_selection_filters(query, selection_filters || [])
    build_range_filters(query, range_filters || [])
    self.struct
  end


  private

  def build_query query
  	self.struct[:body][:query][:filtered][:filter][:bool][:should]  <<  { 
  		terms: { descricao_detalhada_produto: query.downcase.split(" ") , 
  				"execution" => "and", 
  				"_cache" => "true" 
  				}
  			}
  end

  def build_pagination pagination
    
    self.pagination = pagination

    if self.pagination != nil && self.pagination.count != 0
      # self.struct[:size] = pagination.count
      self.struct[:from] = self.pagination.page
    else
      self.pagination.count = 36
      self.pagination.page = 1
    end

  end

  def build_selection_filters query, filters
    Search::SelectionFilterType.constants.each do |type|
      if filters.select { |e| e.type.intern == type }.any? { |e| e.selected  }
        self.struct[:body][:query][:filtered][:filter][:bool][:must] <<
          { terms:{ self.index_of[type] =>  filters.select { |e| e.selected && e.type.intern == type }.map { |filter| filter.value } } }
      end
    end
  end

  def build_range_filters query, filters
    self.struct[:body][:query][:filtered][:filter][:bool][:must]  += filters.map { |filter| filter.build self.index_of[filter.type.intern]  }
  end

end
