class SearchesController < ApplicationController
  
  def show
    client = Elasticsearch::Client.new host: 'http://104.197.50.109:9400';

    search = Search.new(:query => params[:q])
    search.user = current_user

    if search.save
      raw_results = client.search(q: search.query)

      @items = []
      raw_results["hits"]["hits"].each do |hit|
        @items << hit["_source"]["descricao_detalhada_produto"]
      end

      render "items/index"
    else 
      #handle the case where it fails....
    end
  end

  def create
    #TODO: Associate Searches with a user
    client = Elasticsearch::Client.new host: 'http://104.197.50.109:9400';

    search = Search.new(params[:search].permit!)
    search.user = current_user

    if search.save
      raw_results = client.search(q: search.query)

      @items = []
      raw_results["hits"]["hits"].each do |hit|
        @items << hit["_source"]["descricao_detalhada_produto"]
      end

      render "items/index"
    else 
      #handle the case where it fails....
    end
  end
end