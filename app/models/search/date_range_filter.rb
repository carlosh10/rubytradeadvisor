class Search::DateRangeFilter
	
	attr_accessor :from , :to, :type
  
	def initialize from = 0, to = 0, type = nil
		self.from = from
		self.to = to
		self.type = type
	end

	def build index = nil
		{ range: 
				{ 
					(index || type.to_s) => { 
						gte: from, 
						lte: to
					} 
				} 
		}
	end

end
