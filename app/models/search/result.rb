class Search::Result
	
	include Search::SelectionFilterType

	attr_accessor :products, :cif_total, :filters, :range_filters, :hits

	def initialize raw_results, filters = nil, range_filters = nil
		
		self.hits = raw_results["hits"]["total"]
		self.products = raw_results["hits"]["hits"].map { |hit| hit["_source"]  }
	    self.cif_total = raw_results["aggregations"]["cif"]["value"]
	    
		#if don't have any filters in request, get it by search raw_results
	    if filters == nil
	    	#create ncm filters
	    	self.filters = raw_results["aggregations"]["filters"]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, false, Search::SelectionFilterType::Ncm }
	    	#create countiries filters
	    	self.filters += raw_results["aggregations"]["countries_origin"]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, false, Search::SelectionFilterType::CountryOrigin }
			self.filters += raw_results["aggregations"]["countries_aquisition"]["buckets"].map { |e| Search::SelectionFilter.new e["key"], e["doc_count"].to_i, false,  Search::SelectionFilterType::CountryAquisition }
	    else
	    	#set ncm filters 
	    	self.filters = filters
	    	#update contry filters

			selected_countries = self.filters.select { |e| e.type == Filter::FilterType::CountryOrigin && e.selected == true  }
	    	self.filters.delete_if { |e| e.type == Filter::FilterType::CountryOrigin }
	    	self.filters += raw_results["aggregations"]["countries_origin"]["buckets"].map { |e| 
				Search::SelectionFilter.new e["key"], e["doc_count"].to_i, selected_countries.any? { |f| f.value == e["key"] }, SelectionFilterType::CountryOrigin 
			}

			selected_countries = self.filters.select { |e| e.type == Filter::FilterType::CountryAquisition && e.selected == true  }
	    	self.filters.delete_if { |e| e.type == Filter::FilterType::CountryAquisition }
	    	self.filters += raw_results["aggregations"]["countries_aquisition"]["buckets"].map { |e| 
				Search::SelectionFilter.new e["key"], e["doc_count"].to_i, selected_countries.any? { |f| f.value == e["key"] }, SelectionFilterType::CountryAquisition 
			}


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

end