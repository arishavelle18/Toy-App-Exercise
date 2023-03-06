class UserController < ApplicationController
    def index
        @users = User.all
    end
    # this is a member action which loads a single track
    def show
        # get user
        @user = User.find(params[:id])
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save # check if the user is valid
            # user is valid
            flash[:notice] = "User was successfully created."
            redirect_to index_path
        else 
            # valid error
            render :new
        end

    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        # find the user
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "User was successfully updated."
            redirect_to user_path(@user)
        else
            render edit
        end
    end

    # delete the acc
    def destroy
        # find thee id of it
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "User was successfully destroyed."
        redirect_to index_path
    end

    private
    def user_params
        params.require(:user).permit(:name,:email)
    end
end
