class Search::QueryBuilder
	
	def initialize
	end

	def build query, filters
		
		struct = {
	        body: {  
	          query: {
	            bool: {
	              must: [
	              	],
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

		
		struct[:body][:query][:bool][:must] +=  [ { match: { descricao_detalhada_produto: query } } ] 

		if filters != nil && filters.select { |e| e.selected && e.type == FilterType::Ncm }.any? { |e| e.selected  }

			struct[:body][:query][:bool][:must] += 
				filters.select { |e| e.selected && e.type == FilterType::Ncm }.map { |filter| { term: { ncm: filter.value } }  }

			#struct[:body][:query][:bool][:must_not] += 
			#	filters.select { |e| !e.selected && e.type == FilterType::Ncm }.map { |filter| { term: { ncm: filter.value } }  }
		else

		end			

		if filters != nil && filters.select { |e| e.selected && e.type == FilterType::Country }.any? { |e| e.selected  }
			struct[:body][:query][:bool][:must] += 
				filters.select { |e| e.selected && e.type == FilterType::Country }.map { |filter| { term: { siglaPaisAquisicao: filter.value } }  }

			struct[:body][:query][:bool][:must_not] += 
				filters.select { |e| !e.selected && e.type == FilterType::Country }.map { |filter| { term: { siglaPaisOrigem: filter.value } }  }

		end


		struct
	end
end