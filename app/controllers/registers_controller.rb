class RegistersController < ApplicationController
  # go to register
  def new
    @user = User.new
  end
  # create sign up
  def create
    # convert the email into lowercase
    params[:user][:email].downcase
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to index_path,notice:"Successfully created account"
    else
      render :new
    end
  end

  private def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:name)
  end
end
