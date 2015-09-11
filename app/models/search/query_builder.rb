class Search::QueryBuilder

  include Search::SelectionFilterType

  attr_accessor :struct

  def initialize
    self.struct = {
      body: {
        query: {
          filtered: {
            filter: {
              bool: {
                should: [],
                must: []
              }
            }
          }
        },
        aggs: {
          cif: { sum: { field: :CIF } } ,
          filters: { terms: { field: :ncm}   },
          countries_origin: { terms: { field: :siglaPaisOrigem }   },
          countries_aquisition: { terms: { field: :siglaPaisAquisicao }   },
          max_cif: { max: { field: :CIF } }
        }
      }
    }
  end

  def with_index_of type
    return case type
    when Search::SelectionFilterType::Ncm then "ncm"
    when Search::SelectionFilterType::CountryOrigin  then "siglaPaisOrigem"
    when Search::SelectionFilterType::CountryAquisition then "siglaPaisAquisicao"
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
      self.struct[:body][:query][:filtered][:filter][:bool][:must]  += range_filters.map { |e| e.build  }
    end

    self.struct
  end
end
