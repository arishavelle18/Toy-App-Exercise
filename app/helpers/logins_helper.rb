module LoginsHelper
   
    # add method for setting session
    def log_in(user)
        session[:user_id] = user.id
    end

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id:session[:user_id])
        end
    end

    # add restriction
    def require_user_logged_in!
        redirect_to login_path,:alert => "You must be signed in to view that" if Current.user.nil?
    end

    # add restriction
    def require_user_not_logged_in!
        redirect_to microposts_path,:alert => "You must be signed out to view that" if !Current.user.nil?
    end
    
    # log_out
    def log_out 
        session.delete(:user_id)
    end


end
