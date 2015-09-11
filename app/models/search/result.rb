class Search::Result

  include Search::SelectionFilterType

  attr_accessor :products, :cif_total, :filters, :range_filters, :hits

  def initialize raw_results, filters = nil, range_filters = nil

    self.hits = raw_results["hits"]["total"]
    self.products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
    self.cif_total = raw_results["aggregations"]["cif"]["value"]

    #if don't have any filters in request, get it by search raw_results
    if filters == nil
      create_selection_filters raw_results
    else
      update_selection_filters raw_results, filters
    end

    if range_filters == nil
      c = Search::RangeFilter.new 0, raw_results["aggregations"]["max_cif"]["value"], 0, raw_results["aggregations"]["max_cif"]["value"], "CIF"
    else
      c = range_filters.bsearch { |e| e.type == "CIF" }
    end

    self.range_filters = Hash.new
    self.range_filters[:CIF] = Hash.new
    self.range_filters[:CIF][:min] = c.min
    self.range_filters[:CIF][:max] = c.max
    self.range_filters[:CIF][:min_range] = c.min_range
    self.range_filters[:CIF][:max_range] = c.max_range

  end


  private

  def create_selection_filters results

    self.filters = []

    Search::SelectionFilterType.constants.each do |type|
        self.filters += results["aggregations"][type.to_s]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, false, type.to_s }
    end
    
  end

  def update_selection_filters results, filters

    #set all filters
    self.filters = filters

    #update contry filters
    Search::SelectionFilterType.constants.select { |t| t.to_s != Search::SelectionFilterType::Ncm }.each do |type|
      selected_countries = self.filters.select { |e| e.type == type.to_s && e.selected }
      self.filters.delete_if { |e| e.type == type.to_s }
      self.filters += results["aggregations"][type.to_s]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, selected_countries.any? { |f| f.value == e["key"] }, type.to_s }
    end

  end

end
