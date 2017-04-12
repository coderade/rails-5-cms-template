class SubjectsController < ApplicationController

  layout 'admin'

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})
    @subjects_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.save

    if @subject.save
      flash[:notice] =  "The subject #{@subject.name} has been updated successfully."
      redirect_to(subjects_path)
    else
      flash[:error] = "There is an error when trying to create the subject #{@subject.name}. Please try again."
      @subjects_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subjects_count = Subject.count + 1
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
end
