class SubjectsController < ApplicationController

    layout "admin"

    before_action :confirm_logged_in

    #read actions
    #HTTP GET, displays list of records  GET/subjects
  def index
      logger.debug("*** Testing logger ***")
      @subjects = Subject.sorted
  end
  #HTTP GET, displays detailed view of single record GET/subjects:id
  def show
      @subject = Subject.find(params[:id])
  end

  #create actions
  #HTTP GET, create new object to add values to GET/new_subject_path
  def new
      @subject = Subject.new
      @subject_count = Subject.count + 1
  end
  #HTTP POST, adds new object to the database POST/subjects_path
  def create
      # Instantiate new object using form params
      @subject = Subject.new(subject_params) #use private method below to get permited data for mass assignment
      # Save object
      if @subject.save
          # If successful, redirect to index action
          flash[:notice] = "Subject created successfully."
          redirect_to(subjects_path)
      else
          # Else, redisplay form so user can fix problems
          @subject_count = Subject.count + 1
          render('new') # renders form template with original user data pre-populated
      end
  end

  #update actions
  #HTTP GET, display the form GET/edit_subject_path(:id)
  def edit
      @subject = Subject.find(params[:id])
      @subject_count = Subject.count
  end
  #HTTP PATCH, process the form PATCH/subject_path(:id)
  def update
      # Find new object using form params
      @subject = Subject.find(params[:id])
      # Update object
      if @subject.update_attributes(subject_params) #use private method below to get permited data for mass assignment
          # If successful, redirect to show action
          flash[:notice] = "Subject updated successfully."
          redirect_to(subject_path(@subject))
      else
          # Else, redisplay form so user can fix problems
          @subject_count = Subject.count
          render('edit') # renders form template with original pre-populated
      end
  end

  #delete actions
  #HTTP GET, display form GET/delete_subject_path(:id)
  def delete
      @subject = Subject.find(params[:id])
  end
  #HTTP DELETE, process form DELETE/subject_path(:id)
  def destroy
      # find object
      @subject = Subject.find(params[:id])
      # destroy object
      @subject.destroy
      # redirect back to index
      flash[:notice] = "Subject '#{@subject.name}' deleted successfully."
      redirect_to(subjects_path)
  end

  private
  def subject_params
      params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

end
