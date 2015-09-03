class SearchesController < ApplicationController

  def show

    search = Search.new(:query => params[:q], :user => current_user)

    if search.save
      
      raw_results = search_client.search(q: search.query)

      @products = []

      raw_results["hits"]["hits"].each do |hit|
        @products << hit["_source"]#["descricao_detalhada_produto"]
      end

    else 
      #handle the case where it fails....
    end
  end

  def create
    
  end

  private

    def search_client
      Elasticsearch::Client.new host: 'http://104.197.50.109:9400'
    end

end