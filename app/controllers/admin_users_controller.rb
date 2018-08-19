class AdminUsersController < ApplicationController

    layout "admin"

    before_action :confirm_logged_in

    def index
        @admin_users = AdminUser.sorted
    end

    def new
        @admin_user = AdminUser.new
    end

    def create
        # Instantiate new object using form params
        @admin_user = AdminUser.new(admin_user_params) #use private method below to get permited data for mass assignment
        # Save object
        if @admin_user.save
            # If successful, redirect to index action
            flash[:notice] = "Admin user created successfully."
            redirect_to(admin_users_path)
        else
            # Else, redisplay form so user can fix problems
            render('new') # renders form template with original user data pre-populated
        end
    end

    def edit
        @admin_user = AdminUser.find(params[:id])
    end

    def update
        # Find new object using form params
        @admin_user = AdminUser.find(params[:id])
        # Update object
        if @admin_user.update_attributes(admin_user_params) #use private method below to get permited data for mass assignment
        # If successful, redirect to show action
        flash[:notice] = "Admin user updated successfully."
        redirect_to(admin_user_path(@admin_user))
        else
        # Else, redisplay form so user can fix problems
        render('edit') # renders form template with original pre-populated
        end
    end

    def delete
        @admin_user = AdminUser.find(params[:id])
    end

    def destroy
        # find object
        @admin_user = AdminUser.find(params[:id])
        # destroy object
        @admin_user.destroy
        # redirect back to index
        flash[:notice] = "Admin user '#{@admin_user.name}' deleted successfully."
        redirect_to(admin_users_path)
    end

    private
    def admin_user_params
        params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
    end
end
