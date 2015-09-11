class Search::QueryBuilder

  include Search::SelectionFilterType
  include Search::RangeFilterType

  attr_accessor :struct

  def initialize
    self.struct = { 
    	body: { query: { filtered: { filter: { bool: { should: [], must: [] }}}},
    	size: "36",
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
  end

  def with_index_of type
    return case type
    when Search::SelectionFilterType::Ncm then "ncm"
    when Search::SelectionFilterType::CountryOrigin  then "siglaPaisOrigem"
    when Search::SelectionFilterType::CountryAquisition then "siglaPaisAquisicao"
    when Search::RangeFilterType::TotalValue.to_s then "CIF"
    when Search::RangeFilterType::UnityValue.to_s then "CIF_unitario"
    when Search::RangeFilterType::Quantity.to_s then "quantidade_comercializada_produto"
    when Search::RangeFilterType::Customs.to_s then "quantidade_aduaneira"
    else "NotFound"
    end
  end

  def build query, filters = nil, range_filters = nil

    self.struct[:body][:query][:filtered][:filter][:bool][:should] << { term: { descricao_detalhada_produto: query.downcase   }}

    unless filters == nil
      build_selection_filters query, filters
    end

    unless range_filters == nil
      build_range_filters query, range_filters
    end

    self.struct
  end


  private

	  def build_selection_filters query, filters
	    Search::SelectionFilterType.constants.each do |type|
	      if filters.select { |e| e.type.intern == type }.any? { |e| e.selected  }
	        self.struct[:body][:query][:filtered][:filter][:bool][:must] <<
	          { terms:{ with_index_of(type.to_s) =>  filters.select { |e| e.selected && e.type.intern == type }.map { |filter| filter.value } } }
	      end
	    end
	  end

	  def build_range_filters query, filters
	    self.struct[:body][:query][:filtered][:filter][:bool][:must]  += filters.map { |filter| filter.build with_index_of filter.type  }
	  end

end
