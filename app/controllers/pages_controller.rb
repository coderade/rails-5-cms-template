class PagesController < ApplicationController

  layout 'admin'

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @pages_count = Page.count + 1
    @page = Page.new
    @subjects = Subject.sorted
  end

  def create
    @page = Page.new(page_params)
    @page.save

    if @page.save
      flash[:notice] = "The page #{@page} has been created successfully."
      redirect_to(pages_path)
    else
      "There is an error when trying to create the page #{@page.name}. Please try again."
      @pages_count = Page.count
      @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @subjects = Subject.sorted
    @pages_count = Page.count
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:notice] = "The page #{@page.name} has been updated successfully."
      redirect_to(page_path(@page))
    else
      flash[:error] = "There is an error when trying to update the page #{@page.name}. Please try again."
      @pages_count = Page.count
      @subjects = Subject.sorted
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
      redirect_to(pages_path)
    else
      flash[:error] = "There is an error when trying to delete the page #{@page.name}."
      render('delete')
    end

  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end
end
