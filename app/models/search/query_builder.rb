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

		


		if filters != nil && filters.select { |e| e.selected && e.type == FilterType::Ncm }.any? { |e| e.selected  }

			struct[:body][:query][:bool][:should] += 
				filters.select { |e| e.selected && e.type == FilterType::Ncm }.map { |filter| { term: { ncm: filter.value } }  }

						#if filters != nil && filters.select { |e| e.selected && e.type == FilterType::Country }.any? { |e| e.selected  }
						#	struct[:body][:query][:bool][:should] += 
						#		filters.select { |e| e.selected && e.type == FilterType::Country }.map { |filter| { term: { siglaPaisAquisicao: filter.value } }  }

							#struct[:body][:query][:bool][:must_not] += 
							#	filters.select { |e| !e.selected && e.type == FilterType::Country }.map { |filter| { term: { siglaPaisOrigem: filter.value } }  }

						#end

			#struct[:body][:query][:bool][:must_not] += 
			#	filters.select { |e| !e.selected && e.type == FilterType::Ncm }.map { |filter| { term: { ncm: filter.value } }  }
		else
			struct[:body][:query][:bool][:must] +=  [ { match: { descricao_detalhada_produto: query } } ] 
		end			




		struct
	end
end