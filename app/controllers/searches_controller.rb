class SearchesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create

  def show

  end

  def create

    filter = Search::NcmFilter.new "12345678", 123
    filter2 = Search::NcmFilter.new "87654321", 22

    @search = Search.new(search_params)

    @search.filters << filter
    @search.filters << filter2

    @filters = ncm_filters

    if @search.save

      #todo move to query builder
      raw_results = search_client.search body: { query: { match: { descricao_detalhada_produto: @search.query } } , aggs: { cif: { sum: { field: :CIF } } }  }
      
      @products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
      @search.cif_total = raw_results["aggregations"]["cif"]["value"]

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
