class Search::Filter
	
	attr_accessor :ncm , :hits , :selected, :guid

	def initialize ncm, hits, selected = false
		self.ncm = ncm
		self.hits =  hits 
		self.guid = SecureRandom.hex
		self.selected = selected
	end

end