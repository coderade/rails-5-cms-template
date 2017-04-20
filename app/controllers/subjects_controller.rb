class SubjectsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_subjects, :only => [:new, :create, :edit, :update ]
  before_action :set_subjects_count, :only => [:new, :create, :edit, :update ]


  def index
    logger.debug('Testing the logger')
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.save

    if @subject.save
      flash[:notice] =  "The subject #{@subject.name} has been created successfully."
      redirect_to(subjects_path)
    else
      flash[:error] = "There is an error when trying to create the subject #{@subject.name}. Please try again."
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update_attributes(subject_params)
      flash[:notice] =  "The subject #{@subject.name} has been updated successfully."
      redirect_to(subjects_path)
    else
      flash[:error] = "There is an error when trying to update the subject #{@subject.name}. Please try again."
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])

    if @subject.destroy
      flash[:notice] = "The subject #{@subject.name} has been deleted successfully."
      redirect_to(subjects_path)
    else
      flash[:error] = "There is an error when trying to delete the subject #{@subject.name}. Please try again."
      render('delete')
    end

  end
  
  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_subjects_count
    @subjects_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subjects_count += 1
    end
  end

  def find_subjects
    @subjects = Subject.sorted
  end
end
