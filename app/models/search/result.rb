class Search::Result
	
	attr_accessor :products, :cif_total, :filters, :range_filters

	def initialize raw_results, filters = nil, range_filters
		self.products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
	    self.cif_total = raw_results["aggregations"]["cif"]["value"]
	    
		#if don't have any filters in request, get it by search raw_results
	    if filters == nil
	    	#create ncm filters
	    	self.filters = raw_results["aggregations"]["filters"]["buckets"].map { |e| Search::Filter.new e["key"], e["doc_count"].to_i }
	    	#create countiries filters
	    	self.filters += raw_results["aggregations"]["countries"]["buckets"].map { |e| Search::Filter.new e["key"], e["doc_count"].to_i, false, FilterType::Country }
	    else
	    	#set ncm filters 
	    	self.filters = filters
	    	#update contry filters
			selected_countries = self.filters.select { |e| e.type == FilterType::Country && e.selected == true  }
	    	self.filters.delete_if { |e| e.type == FilterType::Country }
	    	self.filters += raw_results["aggregations"]["countries"]["buckets"].map { |e| 
				Search::Filter.new e["key"], e["doc_count"].to_i, selected_countries.any? { |f| f.value == e["key"] }, FilterType::Country 
			}
	    end

#		self.range_filters = Hash.new
#		self.range_filters[:cif] = Hash.new
#		self.range_filters[:cif][:min] = 0
#		self.range_filters[:cif][:max] = raw_results["aggregations"]["max_cif"]["value"]
#		self.range_filters[:cif][:min_range] = 0
#		self.range_filters[:cif][:max_range] = raw_results["aggregations"]["max_cif"]["value"]

		if range_filters == nil 
			c = Search::RangeFilter.new 0, raw_results["aggregations"]["max_cif"]["value"], 0, raw_results["aggregations"]["max_cif"]["value"], "cif"
		else
			c = range_filters.bsearch { |e| e.type == "cif" }
		end

		self.range_filters = Hash.new
		self.range_filters[:cif] = Hash.new
		self.range_filters[:cif][:min] = c.min
		self.range_filters[:cif][:max] = c.max
		self.range_filters[:cif][:min_range] = c.min_range
		self.range_filters[:cif][:max_range] = c.max_range



	end

end