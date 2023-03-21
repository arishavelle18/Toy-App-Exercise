class RegistersController < ApplicationController
  before_action :require_user_not_logged_in!
  
  # go to register
  def new
    @user = User.new
  end
  # create sign up
  def create
    # convert the email into lowercase
    respond_to do |format|
      params[:user][:email] = params[:user][:email].downcase
      @user = User.create(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Successfully created account"
        format.html {redirect_to microposts_path}
      else
        format.html{ render :new , status: :unprocessable_entity}
      end
    end
    
  end

  private def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:name)
  end
end
