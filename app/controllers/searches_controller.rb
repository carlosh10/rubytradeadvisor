class SearchesController < ApplicationController

  def show

  end

  def create

    @search = Search.new(:query => params[:query])

    if @search.save

      raw_results = search_client.search(q: @search.query)

      @products = []

      raw_results["hits"]["hits"].each do |hit|
        @products << hit["_source"]
      end

    else
      #handle the case where it fails....
    end

  end

  private

  def search_client
    Elasticsearch::Client.new host: 'http://104.197.50.109:9400'
  end

end
