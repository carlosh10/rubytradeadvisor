class NcmController < ApplicationController
	
	respond_to :json

	def show
		result = client.search(
			 { body: {
				query: { 
					filtered: { 
						filter: { 
							bool: {
							 must: [ 
							 		{ term: { "prodsense.ncm" => params[:ncm] } }
							 ] 
							}
						}
					}
				},
	            size: "1",
	            from: "1",
	            aggs: {
                	cif: { sum: { field: :CIF } } 
            	}
          	}
          })
       
		@ncm = { key: result["hits"]["hits"].first["_source"]["ncmDescricao"] }
		respond_with @ncm
	end

	private

	def client
      Elasticsearch::Client.new host: Rails.configuration.x.elasticsearch.address + "/_all/"
    end


end
