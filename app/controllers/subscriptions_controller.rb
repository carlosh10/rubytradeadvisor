class SubscriptionsController < ApplicationController
	
	before_filter :authenticate_user!

	def show
		@plan = Plan.find_by_id(plan_id)
		@user = current_user
	end

	def create

	end


	private

	def plan_id
		 params[:plan].to_i
	end

	def subscription
		
	end
end
