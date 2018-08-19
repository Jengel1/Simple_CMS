class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    private
    def confirm_logged_in
        unless session[:user_id]  # if no session id
            flash[:notice] = "Please log in."
            redirect_to(access_logout_path)
            # redirect_to prevents requested action from running
        end
    end
end
