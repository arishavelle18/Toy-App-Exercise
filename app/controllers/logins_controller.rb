class LoginsController < ApplicationController
  before_action :require_user_not_logged_in!, :only => [ :create,:new]
  def new
    @user = User.new()
  end

  def create
    # get the params and always change it into downcase
    user = User.find_by(email:params[:user][:email].downcase)
    # render plain:params[:user][:remember_me] == '1' ? remember(user) : forget(user)
    # check if user exist and authenticate it
    respond_to do |format|
      if user && user.authenticate(params[:user][:password])
        # set the session
        log_in(user)
        # check if the user want to use remember me  or not
        params[:user][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:notice] = "Logged in successfully"
        format.html{redirect_to microposts_path}
      else
        flash[:alert] = "Invalid email or password"
        format.html{ render :new , status: :unprocessable_entity}
      end
    end
  end

  def destroy
    # delete the session
    log_out if logged_in?
    respond_to do |format|
      flash[:notice] = "Logged out"
      format.html {redirect_to login_path}  
    end
  end

end
