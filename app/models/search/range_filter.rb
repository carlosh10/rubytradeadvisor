class Search::RangeFilter
	
	#include FilterType

	attr_accessor :min , :max, :min_range, :max_range, :type
  
	def initialize min  = 0, max = 0, min_range = 0, max_range = 0, type = nil
		self.min = min
		self.max = max
		self.min_range = min_range
		self.max_range = max_range
		self.type = type
	end

	def build
		{ range: 
				{ 
					type.to_s => { 
						gte: min.to_s, 
						lte: max.to_s
					} 
				} 
		}
	end

end


