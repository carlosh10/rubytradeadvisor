class SearchesController < ApplicationController

  skip_before_filter :verify_authenticity_token  
  
  def show
    redirect_to '/'
  end

  def create

    @search = Search.new(search_params)
    @search.user = current_user

    if @search.save
      query_builder = Search::QueryBuilder.new
      raw_results = client.search( 
      	query_builder.build(@search.query, selection_filters, range_filters, pagination, date_range_filters, sort_by))
      @result = Search::Result.new(
      	raw_results, selection_filters, range_filters, query_builder.pagination, date_range_filters,sort_by)
    else
      # todo handle the case where it fails....
    end

  end

  private

    def client
      Elasticsearch::Client.new host: Rails.configuration.x.elasticsearch.address
    end

    def search_params
      params[:search].permit(:query)
    end

    def filters_params
      params[:filters]
    end

    def selection_filters
      if filters_params != nil
        filters_params.map { |e| Search::SelectionFilter.new e[:value], e[:hits] , e[:selected] == "true", e[:type].intern }
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

    def date_range_filters_params
        params[:date_range_filters]
    end

    def date_range_filters
      if date_range_filters_params != nil
       date_range_filters_params.map { |key , value|  Search::DateRangeFilter.new value[:from], value[:to], key }
      end
    end

    def pagination
      if params[:pagination] != nil
        Search::Pagination.new params[:pagination][:total_pages].to_i, params[:pagination][:page].to_i, params[:pagination][:count].to_i
      else
        Search::Pagination.new
      end
    end


    def sort_by
        params[:order]
    end

end
