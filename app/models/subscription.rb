class Subscription < ActiveRecord::Base

	belongs_to :user
	belongs_to :plan

	def self.is_active?
		true
	end

	def self.hire(user)
		if user.active_subscription == nil
			user.subscriptions << self
		end
	end

end
