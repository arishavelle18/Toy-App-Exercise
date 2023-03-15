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
                        flash[:notice] ="Micropost was successfully created"
                        redirect_to microposts_path
                else
                        render :new
                end
            end
        else
             # this portion if the image is not present
            if @micropost.save
                flash[:notice] = "Micropost was successfully created"
                redirect_to microposts_path
            else
                render :new
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
        @micropost = Micropost.find(params[:id])
        # check if the image is present or not
        if params[:micropost][:image].present?
            # render plain:params[:micropost][:image].content_type.in?(%w[image/jpeg image/png])

            # check the image if the file extension is jpeg or png

            if !params[:micropost][:image].content_type.in?(%w[image/jpeg image/png])
                # @micropost = Micropost.new(micropost_params)
                # @micropost.errors.push["File extension is not supported it must be jpeg or png."]
                
                #add error
                @micropost.errors.add(:file,"extension is not supported it must be jpeg or png.")
                render :edit
            else
                # if the image is not present we can just update is
                if @micropost.update(micropost_params)
                        flash[:notice] = "Micropost was successfully updated"
                        redirect_to microposts_path
                else
                        render :edit
                end
            end
        else
            # @micropost = Micropost.new(micropost_params)
            if @micropost.update(micropost_params)
                flash[:notice] = "Micropost was successfully updated"
                redirect_to micropost_path(@micropost)
            else
                render :edit
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
        @microposts= Micropost.all
        @users = User.all.count
    end

    private def micropost_params
        params.require(:micropost).permit(:title,:content,:user_id,:image) 
    end
end
