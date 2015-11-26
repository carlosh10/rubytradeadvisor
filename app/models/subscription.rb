class Subscription < ActiveRecord::Base

	belongs_to :user
	belongs_to :plan
	has_many :payments
	before_create :assign_default
	attr_accessor :iugu

	def is_active?
		iugu_subscription != nil && iugu_subscription.active
	end

	#payed and active
	#def is_pending?
	#end

	def in_trial?
		iugu_subscription.in_trial
	end

	def hire
		if !self.iugu_identifier && !self.user.active_subscription
			subscription = Iugu::Subscription.create({ plan_identifier: self.plan.name, 
				customer_id: self.user.iugu_identifier })
			self.iugu_identifier = subscription.id
			self.save!
			# return subscription.recent_invoices.first["secure_url"]
		end
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
