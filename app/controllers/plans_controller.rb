class PlansController < ApplicationController

	def show
		@plans = Plan.eager_load(:features).where(is_active: true)
	end

end
