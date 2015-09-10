module FilterType
	Ncm = "NCM"
	CountryOrigin = "CONTRY-ORIGIN"
	CountryAquisition = "CONTRY-AQUISITION"
end

class Search::Filter
	
	include FilterType

	attr_accessor :hits , :selected, :guid, :value, :type
  
	def initialize value, hits, selected = false, type = FilterType::Ncm
		self.value = value
		self.hits =  hits 
		self.guid = SecureRandom.hex
		self.selected = selected
		self.type = type
	end

end


