class AdminController < ApplicationController

  before_filter :authenticate_user!

  # view allowed to only system administrators  
  before_filter do 
    redirect_to "/users/sign_in" unless current_user && current_user.is_admin?
  end

  def index
  	@searches = Search.last(30)
  end

end
