class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        if @current_user
            current_user.reset_session_token!
            session[:session_token] = nil
        else
            User.find_by(session_token: session[:session_token])
        end
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        !!current_user
    end

    def required_logged_in
        redirect_to new_sessions_url unless logged_in?
    end

    def required_logged_out
        redirect_to cats_url if logged_in?
    end

    def logout
        current_user.reset_session_token!
        session[:session_token] = nil 
    end

end