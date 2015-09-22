class DashboardController < ApplicationController

  before_filter :authenticate_user!
  
  before_filter do 
    redirect_to "/users/sign_in" unless current_user && current_user.is_admin?
  end

  def index
  	
  end

end
