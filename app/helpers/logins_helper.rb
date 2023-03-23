module LoginsHelper
   
    # add method for setting session
    def log_in(user)
        session[:user_id] = user.id
    end

    def set_current_user
        # check the user if has a session and if not and has a cookies then you can automaticall login
        if (user_id = session[:user_id])
            Current.user ||= User.find_by(id:session[:user_id])
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id:user_id)
            if user && user.authenticate?(cookies[:remember_token])
                # set the session
                log_in user
                Current.user = user
            end
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
    
     def logged_in?
        # my logic : if @current_user has value it return true and if nil the result is false
        !set_current_user.nil?
    end

    # log_out
    def log_out 
        forget(Current.user)
        session.delete(:user_id)
        Current.user = nil
    end

    # set the cookies remember a user in a persistent session
    def remember(user)
        user.remember
        # set permanent cookies
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] =  user.remember_token
    end

    # update the user
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
end
