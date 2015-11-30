class SubscriptionsController < ApplicationController
	
	before_filter :authenticate_user!

	def show
		@has_active_subscription = User.eager_load(:subscriptions).find_by_id(current_user.id).active_subscription
		if not @has_active_subscription
			@plan = Plan.find_by_id(plan_id)
			@user = current_user
			@subscription = Subscription.new plan: @plan, user: @user
		end
	end

	def create
		@subscription = Subscription.new subscription
		@subscription.user = current_user
		@subscription.hire
		redirect_to '/dashboard'
	end

	#def postback
	#end

	private

	def plan_id
		 params[:plan].to_i
	end

	def subscription
		params.require(:subscription).permit(:plan_id)
	end
end
