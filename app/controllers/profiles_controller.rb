class ProfilesController < ApplicationController
  def show
    @user = User.find_by(id:params[:id])
    @microposts = @user.microposts
  end
  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(profile_params)
    if @micropost.save
        flash[:notice] = "User was successfully created."
        redirect_to profile_path(session[:user_id])
    else
        render :new
    end
  end

    private def profile_params
      params.require(:micropost).permit(:content,:user_id) 
    end
end
