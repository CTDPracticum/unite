class ApplicationController < ActionController::Base
before_action :authorized
helper_method :current_user
helper_method :logged_in?

# Handles the current user’s information
    def current_user
        @current_user = (User.find_by(id: session[:user_id]) || User.new)
    end
    
    def require_user
        redirect_to '/login' unless current_user
    end
# Keep track of our current user, but also to check whether they are logged in
    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to '/welcome' unless logged_in?
    end

    def logout
        redirect_to '/users'
    end

    def current_page?
        render partial: "navbar"
    end
end
