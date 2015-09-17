class Search::QueryBuilder

  include Search::SelectionFilterType
  include Search::RangeFilterType
  include Search::DateRangeFilterType

  attr_accessor :struct, :pagination, :index_of, :sort_by

  def initialize
    self.struct = {
      body: { query: { filtered: { filter: { bool: { should: [], must: [] }}}},
              size: "42",
              from: "1",
              aggs: {
                cif: { sum: { field: :CIF } } ,
                Search::SelectionFilterType::Ncm => { terms: { field: :ncm}   },
                Search::SelectionFilterType::CountryOrigin => { terms: { field: :siglaPaisOrigem }   },
                Search::SelectionFilterType::CountryAquisition => { terms: { field: :siglaPaisAquisicao }   },
                Search::RangeFilterType::TotalValue => { stats: { field: :CIF } },
                Search::RangeFilterType::UnityValue => { stats: { field: :CIF_unitario } },
                Search::RangeFilterType::Quantity => { stats: { field: :quantidade_comercializada_produto } },
                Search::RangeFilterType::Customs => { stats: { field: :quantidade_aduaneira } },
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
      Search::RangeFilterType::Customs => :quantidade_aduaneira,
      Search::DateRangeFilterType::Period => :data_ordem 
    }

    self.sort_by = {
      date: :data_ordem,
      unit_value: :CIF_unitario,
      total_value: :CIF,
      quantity: :quantidade_comercializada_produto
    }

  end


  def build query, selection_filters = nil, range_filters = nil, pagination = nil, date_range_filters = [], sort = nil
  	build_query(query)
    build_pagination(pagination)
    build_selection_filters(query, selection_filters || [])
    build_range_filters(query, range_filters || [])
    build_range_filters(query, date_range_filters || [])
    build_sort(sort)
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
    
    self.pagination = pagination || Search::Pagination.new

    if self.pagination != nil && self.pagination.count != 0
      # self.struct[:size] = pagination.count
      self.struct[:body][:from] = self.pagination.page
    else
      self.pagination.count = 42
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

  def build_sort sort
    unless sort == nil && sort_by[sort] == nil
      self.struct[:body][:sort] =  [{ sort_by[sort.intern] => { order: :desc,  ignore_unmapped: :true }}]
    end
  end

end
