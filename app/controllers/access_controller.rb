class AccessController < ApplicationController

    layout 'admin'

    before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

    def menu
        # display text and links
    end

    def login
        # login form
    end

    def attempt_login
        if params[:username].present? && params[:password].present?  # .present? -- is not blank
            found_user = AdminUser.where(:username => params[:username]).first  # .first eliminates array return value and just returns one record
            if found_user
                authorized_user = found_user.authenticate(params[:password])
            end
        end

        if authorized_user
            session[:user_id] = authorized_user.id  # set session id as authorized user id
            flash[:notice] = "You are now logged in."
            redirect_to(admin_path)
        else
            flash.now[:notice] = "Invalid username/password combination."  # flash.now shows up on same page instead of next page
            render('login')
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = 'Logged out'
        redirect_to(access_login_path)
    end

    private
    def confirm_logged_in
        unless session[:user_id]  # if no session id
            flash[:notice] = "Please log in."
            redirect_to(access_logout_path)
            # redirect_to prevents requested action from running
        end
    end
end
