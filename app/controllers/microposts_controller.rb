class MicropostsController < ApplicationController
    # add messaage
    # add_flash_types :info, :error, :warning
    # list all the data
    def index
        # render the all the data
        @microposts= Micropost.all
        
    end
    # navigate to form
    def new
        # create form
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
        @micropost = Micropost.find(params[:id])
    
    end
    
    def update
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
        # find thee id of it
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "User was successfully destroyed."
        redirect_to microposts_path
    end


    private def micropost_params
        params.require(:micropost).permit(:content,:user_id) 
    end
end
