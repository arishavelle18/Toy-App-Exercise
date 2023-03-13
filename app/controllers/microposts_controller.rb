class MicropostsController < ApplicationController
    before_action :require_user_logged_in!
    # add messaage
    # add_flash_types :info, :error, :warning
    # list all the data
    def index
        # render the all the data
        @microposts= Micropost.all
        @users = User.all.count
    end
    # navigate to form
    def new
        @micropost = Micropost.new
    end
    # create the post
    def create
        @micropost = Micropost.new(micropost_params)
        if @micropost.save
            flash[:notice] = "User was successfully created."
            redirect_to microposts_path
        else
            render :new
        end
    end

    def show
        @micropost = Micropost.find(params[:id])
    end
    
    def edit
        @micropost = Micropost.find_by(id:params[:id])
        if Current.user.id != @micropost[:user_id]
            redirect_to microposts_path,:alert => "Unauthorize Access"
        end
        @micropost = Micropost.find(params[:id])
    
    end
    
    def update
        @micropost = Micropost.find_by(id:params[:id])
        if Current.user.id != @micropost[:user_id]
            redirect_to microposts_path,:alert => "Unauthorize Access"
        end
        @micropost = Micropost.find(params[:id])
        if @micropost.update(micropost_params)
            flash[:notice] = "Micropost was successfully updated"
            redirect_to micropost_path(@micropost)
        else
            render :edit
        end
    end
   
    # delete the acc
    def destroy
        
        @micropost = Micropost.find_by(id:params[:id])
        if  Current.user.id != @micropost[:user_id]
            redirect_to microposts_path,:alert => "Unauthorize Access"
        else
            # find thee id of it
            @micropost = Micropost.find(params[:id])
            @micropost.destroy
            flash[:notice] = "User was successfully destroyed."
            redirect_to microposts_path
        end
    end


    private def micropost_params
        params.require(:micropost).permit(:content,:user_id) 
    end
end
