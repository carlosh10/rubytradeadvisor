class Search::QueryBuilder

  include Search::SelectionFilterType
  include Search::RangeFilterType

  attr_accessor :struct

  def initialize
    self.struct = { body: { query: { filtered: { filter: { bool: { should: [], must: [] }}}},
        aggs: {
          cif: { sum: { field: :CIF } } ,
          Search::SelectionFilterType::Ncm => { terms: { field: :ncm}   },
          Search::SelectionFilterType::CountryOrigin => { terms: { field: :siglaPaisOrigem }   },
          Search::SelectionFilterType::CountryAquisition => { terms: { field: :siglaPaisAquisicao }   },
          Search::RangeFilterType::TotalValue => { max: { field: :CIF } }
        }
      }
    }
  end

  def with_index_of type
    return case type
    when Search::SelectionFilterType::Ncm then "ncm"
    when Search::SelectionFilterType::CountryOrigin  then "siglaPaisOrigem"
    when Search::SelectionFilterType::CountryAquisition then "siglaPaisAquisicao"
    when "TotalValue" then "CIF"
    else "NotFound"
    end
  end

  def build query, filters = nil, range_filters = nil

    self.struct[:body][:query][:filtered][:filter][:bool][:should] << { term: { descricao_detalhada_produto: query.downcase   }}

    unless filters == nil
      Search::SelectionFilterType.constants.each do |type|
        if filters.select { |e| e.type.intern == type }.any? { |e| e.selected  }
          self.struct[:body][:query][:filtered][:filter][:bool][:must] <<
            { terms:{ with_index_of(type.to_s) =>  filters.select { |e| e.selected && e.type.intern == type }.map { |filter| filter.value } } }
        end
      end
    end

    unless range_filters == nil
      self.struct[:body][:query][:filtered][:filter][:bool][:must]  += range_filters.map { |filter| filter.build with_index_of filter.type  }
    end

    self.struct
  end
end
