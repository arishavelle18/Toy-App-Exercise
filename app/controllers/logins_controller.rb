class LoginsController < ApplicationController
  before_action :require_user_not_logged_in!, :only => [ :create,:new]
  def new
    @user = User.new()
  end

  def create
    # check if the params is not present
    respond_to do |format|
      if !params[:user].present?
        flash[:alert] = "Invalid email or password"
        format.html {redirect_to login_path}
      else
        params[:user][:email] = params[:user][:email].downcase
        @user = User.find_by(email:params[:user][:email])
        # check the email in thee storage
        # check if the user is present
        if @user.present? && @user.authenticate(params[:user][:password])
          # set the session
          session[:user_id] = @user.id
          flash[:notice] = "Logged in successfully"
          format.html{redirect_to microposts_path}
        else
          flash[:alert] = "Invalid email or password"
          format.html{ render :new , status: :unprocessable_entity}
        end
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

end
