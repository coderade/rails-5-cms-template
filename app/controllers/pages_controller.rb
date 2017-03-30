class PagesController < ApplicationController

  layout 'admin'

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    @page.save

    if @page.save
      flash[:notice] = 'Page created sucessfully'
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:notice] = 'Page updated sucessfully.'
      redirect_to(page_path(@page))
    else
      flash[:error] = "There is an error when trying ot delete the page #{@page}. Please try again."
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])

    if @page.destroy
      flash[:notice] = "Page #{@page.name} has been deleted sucessfully"
      redirect_to(pages_path)
    else
      flash[:error] = "There is an error when trying ot delete the page #{@page.name}."
      render('delete')
    end

  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end
end
