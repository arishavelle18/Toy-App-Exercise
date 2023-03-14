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
    # check if the image is present 
    if params[:micropost][:image].present?
        
        # check if the image has a file extension of jpeg and png
        if !params[:micropost][:image].content_type.in?(%w[image/jpeg image/png])
            # add error if the image is not supported
            @micropost.errors.add(:file,"extension is not supported it must be jpeg or png.")
            render :new
        else
            # this portion if the image is supported
            if @micropost.save
                flash[:notice] = "Micropost was successfully created."
                redirect_to profile_path(session[:user_id])
            else
                    render :new
            end
        end
    else
        # this portion if the image is not present
       if @micropost.save
        flash[:notice] = "Micropost was successfully created."
        redirect_to profile_path(session[:user_id])
       else
           render :new
       end
    end


    # @micropost = Micropost.new(profile_params)
    # if @micropost.save
    #     flash[:notice] = "User was successfully created."
    #     redirect_to profile_path(session[:user_id])
    # else
    #     render :new
    # end
  end

    private def profile_params
      params.require(:micropost).permit(:title,:content,:user_id,:image) 
    end
end
