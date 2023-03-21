class MicropostsController < ApplicationController
    before_action :require_user_logged_in!
    # add messaage
    # add_flash_types :info, :error, :warning
    # list all the data
    def index
        # render the all the data
        @microposts= Micropost.all.order(id: :desc)
        @users = User.all.count
    end
    # navigate to form
    def new
        @micropost = Micropost.new
    end
    # create the post
    def create
        @micropost = Micropost.new(micropost_params)
       
        respond_to do |format|
            if @micropost.save
                flash[:notice] = "Micropost was successfully created"
                format.html {redirect_to microposts_path}
                # redirect_to microposts_path
            else
                format.html { render :new,status: :unprocessable_entity }
            end
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
        respond_to do |format|
            # if the length of the image is less than one meaning no images it will run without image params  else micropost params
            if params[:micropost][:images].length <=1? @micropost.update(micropost_params_without_image):@micropost.update(micropost_params)
                flash[:notice] = "Micropost was successfully updated"
                format.html { redirect_to micropost_path(@micropost) }
               
            else
                format.html { render :edit , status: :unprocessable_entity}
            end
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

    def indexhello
        @micropost= Micropost.new
        @users = User.all.count
    end

    private def micropost_params
        params.require(:micropost).permit(:title,:content,:user_id,images:[]) 
    end
    private def micropost_params_without_image
        params.require(:micropost).permit(:title,:content,:user_id)
    end
end
