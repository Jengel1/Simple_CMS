class SectionsController < ApplicationController

    layout "admin"

    #read actions
    #HTTP GET, displays list of records  GET/sections
    def index
        @sections = Section.sorted
    end
    #HTTP GET, displays detailed view of single record GET/sections:id
    def show
        @sections = Section.find(params[:id])
    end

    #create actions
    #HTTP GET, create new object to add values to GET/new_section_path
    def new
      @section = Section.new
    end
    #HTTP POST, adds new object to the database POST/sections_path
    def create
      # Instantiate new object using form params
      @section = Section.new(section_params) #use private method below to get permited data for mass assignment
      # Save object
      if @section.save
          # If successful, redirect to index action
          flash[:notice] = "Section created successfully."
          redirect_to(sections_path)
      else
          # Else, redisplay form so user can fix problems
          render('new') # renders form template with original user data pre-populated
      end
    end

    #update actions
    #HTTP GET, display the form GET/edit_section_path(:id)
    def edit
      @section = Section.find(params[:id])
    end
    #HTTP PATCH, process the form PATCH/section_path(:id)
    def update
      # Find new object using form params
      @section = Section.find(params[:id])
      # Update object
      if @section.update_attributes(section_params) #use private method below to get permited data for mass assignment
          # If successful, redirect to show action
          flash[:notice] = "Section updated successfully."
          redirect_to(section_path(@section))
      else
          # Else, redisplay form so user can fix problems
          render('edit') # renders form template with original pre-populated
      end
    end

    #delete actions
    #HTTP GET, display form
    def delete
      @section = Section.find(params[:id])
    end
    #HTTP DELETE, process form
    def destroy
      # find object
      @section = Section.find(params[:id])
      # destroy object
      @section.destroy
      # redirect back to index
      flash[:notice] = "Section '#{@section.name}' deleted successfully."
      redirect_to(sections_path)
    end

    private
    def section_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

end
