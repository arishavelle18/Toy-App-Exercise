class LoginsController < ApplicationController
  before_action :require_user_not_logged_in!, :only => [ :create,:new]
  def new
    @user = User.new()
  end

  def create
    # check if the params is not present
    if !params[:user].present?
      # @user = User.find_by(email:params[:user][:email])
      # flash[:alert] = "Invalid email or password"
      redirect_to login_path,:alert =>"Invalid email or password"
      # render :new
    else
      @user = User.find_by(email:params[:user][:email])
        # check the email in thee storage
      # check if the user is present
      if @user.present? && @user.authenticate(params[:user][:password])
        # set the session
        session[:user_id] = @user.id
        redirect_to microposts_path,notice:"Logged in successfully"
      else
        flash[:alert] = "Invalid email or password"
        render :new
      end
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to login_path,:notice => "Logged out"
    else
      # for accessing it with out permission 
      redirect_to login_path,:alert => "Unauthorized Access"
      
    end
  
  end


  private def login_params
    params.require(:user).permit(:email,:password)
  end

end
