class Subscription < ActiveRecord::Base

	def self.is_active?
		true
	end
	
end
