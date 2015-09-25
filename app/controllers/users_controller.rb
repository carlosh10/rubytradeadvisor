class UsersController < ApplicationController

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    @user = User.find(params[:id].to_i)
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to '/', notice: 'Perfil atualizado com sucesso!.'
      else
        @show_errors = true
      end
    end
  end

  def user_params
    accessible = [ :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

end
