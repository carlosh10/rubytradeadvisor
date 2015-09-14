class SearchesController < ApplicationController

  def show
    redirect_to '/'
  end

  def create

    @search = Search.new(search_params)
    @search.user = current_user

    if @search.save
      raw_results = client.search query.build(@search.query, filters, range_filters)
      @result = Search::Result.new raw_results, filters, range_filters
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
        filters_params.map { |e| Search::SelectionFilter.new e[:value], e[:hits] , e[:selected] == "true", e[:type] }
      end
    end


    def range_filters_params
        params[:range_filters]
    end

    def range_filters
      if range_filters_params != nil
       range_filters_params.map { |key , value|  Search::RangeFilter.new value[:min], value[:max], value[:min_range], value[:max_range], key }
      end
    end

    def query
      Search::QueryBuilder.new
    end

end
