class Search::Result
	
	attr_accessor :products, :cif_total, :filters

	def initialize raw_results, filters = nil
		self.products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
	    self.cif_total = raw_results["aggregations"]["cif"]["value"]
	    
		#if don't have any filters in request, get it by search raw_results
	    if filters == nil
	    	self.filters = raw_results["aggregations"]["filters"]["buckets"].map { |e| Search::Filter.new e["key"], e["doc_count"].to_i }
	    	self.filters += raw_results["aggregations"]["countries"]["buckets"].map { |e| Search::Filter.new e["key"], e["doc_count"].to_i, false, FilterType::Country }
	    else
	    	self.filters = filters
			selected_countries = self.filters.select { |e| e.type == FilterType::Country && e.selected == true  }
	    	self.filters.delete_if { |e| e.type == FilterType::Country }
	    	self.filters += raw_results["aggregations"]["countries"]["buckets"].map { |e| 
				Search::Filter.new e["key"], e["doc_count"].to_i, selected_countries.any? { |f| f.value == e["key"] }, FilterType::Country 
			}
	    end
	end

end