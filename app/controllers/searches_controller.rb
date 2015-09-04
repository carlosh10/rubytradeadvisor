class SearchesController < ApplicationController

  #todo remove to deploy
  skip_before_filter :verify_authenticity_token, :only => :create

  def show

  end

  def create

    @search = Search.new(search_params)

    if @search.save

      #todo move to query builder
      raw_results = search_client.search body: { 
        query: { match: { descricao_detalhada_produto: @search.query } } , 
        aggs: { 
          cif: { sum: { field: :CIF } } ,
          filters: { terms: { field: :ncm}   }
        }}
      
      @result = Search::Result.new raw_results

    else
      # todo handle the case where it fails....
    end

  end

  private

    def search_client
      Elasticsearch::Client.new host: 'http://104.197.50.109:9400'
    end

    def search_params
      params[:search].permit!
    end

    def filters_params
      params[:filters]
    end

    def ncm_filters
      if filters_params != nil
        filters_params.map { |e| Search::NcmFilter.new e[:ncm], e[:hits] }
      end
    end

end
