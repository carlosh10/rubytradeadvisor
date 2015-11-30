class DashboardController < ApplicationController

	def get
		@user = User.eager_load(:subscriptions).find_by_id(current_user.id)
		@subscription = @user.active_subscription
	end

end
