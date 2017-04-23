class PagesController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_current_subject
  before_action :find_subjects, :only => [:new, :create, :edit, :update ]
  before_action :set_pages_count, :only => [:new, :create, :edit, :update ]

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:subject_id => @subject.id)
  end

  def create
    @page = Page.new(page_params)
    
    if @page.save
      flash[:notice] = "The page #{@page.name} has been created successfully."
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      "There is an error when trying to create the page #{@page.name}. Please try again."
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:notice] = "The page #{@page.name} has been updated successfully."
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      flash[:error] = "There is an error when trying to update the page #{@page.name}. Please try again."
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])

    if @page.destroy
      flash[:notice] = "The page #{@page.name} has been deleted successfully."
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      flash[:error] = "There is an error when trying to delete the page #{@page.name}."
      render('delete')
    end

  end

  private

  def find_current_subject
    @subject = Subject.find(params[:subject_id])
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_pages_count
    @pages_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @pages_count += 1
    end
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end

end
