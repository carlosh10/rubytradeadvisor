class Search::QueryBuilder
	
	def build query, filters = nil, range_filters = nil 

		struct = {
				body: {
					query: {
						filtered: {
							filter: {
								bool: {
									should: [{ term: { descricao_detalhada_produto: query }}],
									must: []
								}
							}
						}
					},
					aggs: { 
						cif: { sum: { field: :CIF } } ,
						filters: { terms: { field: :ncm}   },
						countries: { terms: { field: :siglaPaisOrigem }   },
						max_cif: { max: { field: :CIF } }
					} 
				}
			}
		
		if filters != nil && filters.select { |e| e.selected && e.type == FilterType::Ncm }.any? { |e| e.selected  }
			struct[:body][:query][:filtered][:filter][:bool][:must][0] =  { terms: [] } 
			struct[:body][:query][:filtered][:filter][:bool][:must][0][:terms] = { ncm: 
				filters.select { |e| e.selected && e.type == FilterType::Ncm }.map { |filter| filter.value  }  }
		end			 

		if filters != nil && filters.select { |e| e.selected && e.type == FilterType::Country }.any? { |e| e.selected  }
			struct[:body][:query][:filtered][:filter][:bool][:must][1] =  { terms: [] } 
			struct[:body][:query][:filtered][:filter][:bool][:must][1][:terms] = { siglaPaisOrigem:
				filters.select { |e| e.selected && e.type == FilterType::Country }.map { |filter| filter.value }}
		end


		unless range_filters == nil
			struct[:body][:query][:filtered][:filter][:bool][:must]  += range_filters.map { |e| e.build  }
		end


		struct
	end
end