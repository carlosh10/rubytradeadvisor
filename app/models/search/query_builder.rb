class Search::QueryBuilder
	
	def initialize
	end

	def build query, filters
		struct = {
	        body: {  
	          query: {
	            bool: {
	              must: [ 
	             #   { term: { ncm: "85171231" } } ,  
	                {  match: { descricao_detalhada_produto: query } } 
	              ],
	              must_not: [],
	              should: []

	            }
	          }, 
	          aggs: { 
	            cif: { sum: { field: :CIF } } ,
	            filters: { terms: { field: :ncm}   }
	          } 
	        }
		}

		if filters != nil && filters.any? { |e| e.selected  }
			struct[:body][:query][:bool][:should] += 
				filters.select { |e| e.selected  }.map { |filter| { term: { ncm: filter.ncm } }  }
			struct[:body][:query][:bool][:must_not] += 
				filters.select { |e| !e.selected  }.map { |filter| { term: { ncm: filter.ncm } }  }
		end

		struct
	end

end