class PagesController < ApplicationController

    layout "admin"

    before_action :confirm_logged_in
    before_action :find_subject
    before_action :set_page_count, :only => [:new, :create, :edit, :update]

    #read actions
    #HTTP GET, displays list of records  GET/pages
    def index
        @pages = @subject.pages.sorted
    end
    #HTTP GET, displays detailed view of single record GET/pages:id
    def show
        @page = Page.find(params[:id])
    end

    #create actions
    #HTTP GET, create new object to add values to GET/new_page_path
    def new
        @page = Page.new(:subject_id => @subject.id)
    end
    #HTTP POST, adds new object to the database POST/pages_path
    def create
        # Instantiate new object using form params
        @page = Page.new(page_params) #use private method below to get permited data for mass assignment
        @page.subject = @subject
        # Save object
        if @page.save
            # If successful, redirect to index action
            flash[:notice] = "Page created successfully."
            redirect_to(pages_path(:subject_id => @subject.id))
        else
            # Else, redisplay form so user can fix problems
            render('new') # renders form template with original user data pre-populated
        end
    end

    #update actions
    #HTTP GET, display the form GET/edit_page_path(:id)
    def edit
        @page = Page.find(params[:id])
    end
    #HTTP PATCH, process the form PATCH/page_path(:id)
    def update
        # Find new object using form params
        @page = Page.find(params[:id])
        # Update object
        if @page.update_attributes(page_params) #use private method below to get permited data for mass assignment
        # If successful, redirect to show action
        flash[:notice] = "Page updated successfully."
        redirect_to(page_path(@page, :subject_id => @subject.id))
        else
        # Else, redisplay form so user can fix problems
        render('edit') # renders form template with original pre-populated
        end
    end

    #delete actions
    #HTTP GET, display form GET/delete_page_path(:id)
    def delete
        @page = Page.find(params[:id])
    end
    #HTTP DELETE, process form DELETE/page_path(:id)
    def destroy
        # find object
        @page = Page.find(params[:id])
        # destroy object
        @page.destroy
        # redirect back to index
        flash[:notice] = "Page '#{@page.name}' deleted successfully."
        redirect_to(pages_path(:subject_id => @subject.id))
    end

    private
    def page_params
        params.require(:page).permit(:name, :position, :visible, :permalink, :created_at)
    end

    def find_subject
        @subject = Subject.find(params[:subject_id])
    end

    def set_page_count
        @page_count = @subject.pages.count
        if params[:action] == 'new' || params[:action] == 'create'
            @page_count += 1
        end
    end
end
