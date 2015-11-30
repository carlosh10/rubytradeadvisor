class Subscription < ActiveRecord::Base

	belongs_to :user
	belongs_to :plan
	has_many :payments
	before_create :assign_default
	
	attr_accessor :iugu

	def is_active?
		iugu_subscription != nil && iugu_subscription.active
	end


	def in_trial?
		iugu_subscription.in_trial
	end

	def expires_at
		self.due_date
	end

	def expires_at=(date)
		self.due_date = date
	end

	def hire
		if !self.iugu_identifier && !self.user.active_subscription
			self.due_date = Date.today + self.plan.free_days
			subscription = Iugu::Subscription.create({ plan_identifier: self.plan.name, 
				customer_id: self.user.iugu_identifier })
			self.iugu_identifier = subscription.id
			self.save!
		end
	end


	def remaining_trial_days
		if in_trial? then (self.due_date - Date.today).to_i else 0 end
	end

	def suspend
	end

	def reactivate
	end

	private

	def assign_default
		self.due_date ||= Time.now
	end

	def iugu_subscription
		if self.iugu == nil
		 self.iugu = Iugu::Subscription.fetch(self.iugu_identifier)
		end
		return self.iugu
	end


end
