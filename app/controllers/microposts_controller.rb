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
        # render plain:params[:micropost][:images]
        
        respond_to do |format|
            if @micropost.save

                 # check if the image is present or not
                if !params[:micropost][:images].nil?
                    # add image
                    images = JSON.parse(@micropost[:images].to_json)
                    hello = ""
                    params[:micropost][:images].each do |image|
                        hello = image
                        if !image.blank?
                            result = Cloudinary::Uploader.upload(image)
                            # push
                            images["images"] << result["public_id"]
                        end
                    end
                    @micropost[:images] = images.to_json
                    @micropost.save
                end
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
            if @micropost.update(micropost_params)
                # @micropost.image = "sad"
                if params[:micropost][:images].length > 1 &&  JSON.parse(@micropost[:images].to_json)["images"].length > 0
                    JSON.parse(@micropost[:images].to_json)["images"].each do |image|
                        Cloudinary::Uploader.destroy(image) 
                    end
                end
                
                if !params[:micropost][:images].nil? && params[:micropost][:images].length > 1
                    # add image
                    
                    images = { "images" => []}

                    params[:micropost][:images].each do |image|
                        
                        if !image.blank?
                            result = Cloudinary::Uploader.upload(image)
                            # push
                            images["images"] << result["public_id"]
                        end
                    end
                    images = images
                    @micropost.update_attribute("images",images)
                end
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
            if JSON.parse(@micropost[:images].to_json)["images"] != "images" && JSON.parse(@micropost[:images].to_json)["images"].length >  0 
                JSON.parse(@micropost[:images].to_json)["images"].each do |image|
                    Cloudinary::Uploader.destroy(image) 
                end
            end
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
        params.require(:micropost).permit(:title,:content,:user_id) 
    end
    private def micropost_params_without_image
        params.require(:micropost).permit(:title,:content,:user_id)
    end
end
