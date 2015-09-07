class Search::QueryBuilder
	
	def initialize
	end

	def build query, filters
		
		struct = {
	        body: {  
	          query: {
	            bool: {
	              must: [],
	              must_not: [],
	              should: []
	            }
	          }, 
	          aggs: { 
	            cif: { sum: { field: :CIF } } ,
	            filters: { terms: { field: :ncm}   },
	            countries: { terms: { field: :siglaPaisOrigem }   }
	          } 
	        }
		}
		
		struct = {
				body: {
					query: {
						filtered: {
							filter: {
								bool: {
									should: [
										{ term: { descricao_detalhada_produto: query }}
									],
									must: [
#										{
#											terms: {
#												ncm: []
#											}
#										},
#										{
#											terms: {
#												siglaPaisOrigem: []
#											}
#										}
									]
								}
							}
						}
					},
					aggs: { 
						cif: { sum: { field: :CIF } } ,
						filters: { terms: { field: :ncm}   },
						countries: { terms: { field: :siglaPaisOrigem }   }
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
				filters.select { |e| e.selected && e.type == FilterType::Country }.map { |filter| filter.value }
			}
		end


		struct
	end
end