class ProfilesController < ApplicationController
  before_action :require_user_logged_in!
  def show
    @user = User.find_by(id:params[:id])
    @microposts = @user.microposts.order(id: :desc)
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(profile_params)
    # check if the image is present 
    respond_to do |format|
      if @micropost.save
        flash[:notice] = "Micropost was successfully created."
        format.html { redirect_to profile_path(session[:user_id]) }
        
      else
        format.html {render :new, status: :unprocessable_entity}
      end
    end
    
  end

    private def profile_params
      params.require(:micropost).permit(:title,:content,:user_id,images:[]) 
    end
end
