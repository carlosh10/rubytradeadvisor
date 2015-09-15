class Search::Result

  include Search::SelectionFilterType
  include Search::RangeFilterType

  attr_accessor :products, :cif_total, :filters, :range_filters, :hits, :pagination

  def initialize raw_results, filters = [], range_filters = [], pagination = nil

    self.range_filters = Hash.new
    self.hits = raw_results["hits"]["total"]
    self.products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
    self.cif_total = raw_results["aggregations"]["cif"]["value"]
    
    self.pagination = pagination
    self.pagination.total_pages = (self.hits / self.pagination.count).to_i

    #if don't have any filters in request, get it by search raw_results
    if filters == nil
      create_selection_filters raw_results
    else
      update_selection_filters raw_results, filters
    end


    if range_filters == nil
      Search::RangeFilterType.constants.each do |type|
        self.range_filters[type.to_s] = Search::RangeFilter.new 0, raw_results["aggregations"][type.to_s]["value"], 0, raw_results["aggregations"][type.to_s]["value"], type
      end
    else
      range_filters.each do |range_filter|
        self.range_filters[range_filter.type] = range_filter
      end
    end

  end


  private

  def create_selection_filters results

    self.filters = []

    Search::SelectionFilterType.constants.each do |type|
      self.filters += results["aggregations"][type.to_s]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, false, type }
    end

  end

  def update_selection_filters results, filters

    #set all filters
    self.filters = filters

    #update contry filters
    Search::SelectionFilterType.constants.select { |t| t != Search::SelectionFilterType::Ncm }.each do |type|
      selected_countries = self.filters.select { |e| e.type.intern == type.intern && e.selected }
      self.filters.delete_if { |e| e.type.intern == type.intern }
      self.filters += results["aggregations"][type.to_s]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, selected_countries.any? { |f| f.value == e["key"] }, type.to_s }
    end

  end

end
