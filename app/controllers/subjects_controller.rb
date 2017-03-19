class SubjectsController < ApplicationController

  def index
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
      flash[:notice] = 'Subject created sucessfully'
      redirect_to(subjects_path)
    else
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update_attributes(subject_params)
      flash[:notice] = 'Subject updated sucessfully.'
      redirect_to(subjects_path)
    else
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])

    if @subject.destroy
      flash[:notice] = "Subject #{@subject.name} has been deleted sucessfully"
      redirect_to(subjects_path)
    else
      render('delete')
    end

  end
  
  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end
end
