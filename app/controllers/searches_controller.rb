class SearchesController < ApplicationController

  #todo remove to deploy
  skip_before_filter :verify_authenticity_token, :only => :create

  def show

  end

  def create

    @search = Search.new(search_params)

    if @search.save

      #todo move to query builder
      raw_results = client.search query.build(@search.query, filters)
        
      @result = Search::Result.new raw_results, filters

      @raw = query.build(@search.query, filters)
    else
      # todo handle the case where it fails....
    end

  end

  private

    def client
      Elasticsearch::Client.new host: 'http://104.197.50.109:9400'
    end

    def search_params
      params[:search].permit!
    end

    def filters_params
      params[:filters]
    end

    def filters
      if filters_params != nil
        filters_params.map { |e| Search::Filter.new e[:value], e[:hits] , e[:selected] == "true", e[:type] }
      end
    end

    def query
      Search::QueryBuilder.new
    end

end
