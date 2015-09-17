class Search::Result

  include Search::SelectionFilterType
  include Search::RangeFilterType

  attr_accessor :products, :cif_total, :filters, :range_filters, :hits, :pagination, :date_range_filters

  def initialize raw_results, filters = [], range_filters = [], pagination = nil, date_range_filters = nil
    parse_results(raw_results)
    build_pagination(pagination)
    update_selection_filters(raw_results, filters)
    update_range_filters(raw_results, range_filters)
    set_date_range_filters(date_range_filters)
  end

  private

  def parse_results raw_results
    self.filters = []
    self.range_filters = Hash.new
    self.hits = raw_results["hits"]["total"]
    self.products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
    self.cif_total = raw_results["aggregations"]["cif"]["value"]
  end

  def build_pagination pagination
    self.pagination = pagination
    self.pagination.total_pages = (self.hits / self.pagination.count).to_i
  end

  def update_selection_filters results, filters

    filters ||=  []
    skip = Search::SelectionFilterType::Ncm

    Search::SelectionFilterType.constants.each do |type|
      
      if type == skip && filters.count > 0 
        self.filters += filters.select { |f| f.type == skip }
        next
      end

      self.filters += results["aggregations"][type.to_s]["buckets"].map { |e| 
        Search::SelectionFilter.new e["key"], e["doc_count"].to_i,  
        filters.any? { |f| f.value == e["key"] && f.type.intern == type && f.selected }, type 
      }

    end   
    
  end

  def update_range_filters results, range_filters

    if range_filters == nil
      Search::RangeFilterType.constants.each do |type|
        min = results["aggregations"][type.to_s]["min"]
        max = results["aggregations"][type.to_s]["max"]
        self.range_filters[type.to_s] = Search::RangeFilter.new min, max, min , max, type
      end
    else
      range_filters.each do |range_filter|
        self.range_filters[range_filter.type] = range_filter
      end
    end

  end

  def set_date_range_filters date_range_filters
    self.date_range_filters = Hash.new
    if date_range_filters == nil
      self.date_range_filters[Search::DateRangeFilterType::Period.to_s] = Search::DateRangeFilter.new  5.years.ago.to_date.to_s,  DateTime.now.to_date.to_s, Search::DateRangeFilterType::Period
    else
      date_range_filters.each do |filter|
        self.date_range_filters[filter.type] = filter
      end
    end
  end

end
