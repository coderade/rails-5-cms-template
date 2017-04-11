class SectionsController < ApplicationController

  layout 'admin'

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
    @sections_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    @section = Section.new(section_params)
    @section.save

    if @section.save
      flash[:notice] = "The section #{@section.name} has been created successfully."
      redirect_to(sections_path)
    else
      "There is an error when trying to create the section #{@section.name}. Please try again."
      @sections_count = Section.count + 1
      @pages = Page.sorted
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @sections_count = Section.count + 1
    @pages = Page.sorted
  end

  def update
    @section = Section.find(params[:id])

    if @section.update_attributes(section_params)
      flash[:notice] = "The section #{@section.name} has been updated successfully."
      redirect_to(section_path(@section))
    else
      flash[:error] = "There is an error when trying to update the section #{@section.name}. Please try again."
      @sections_count = Section.count + 1
      @pages = Page.sorted
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])

    if @section.destroy
      flash[:notice] = "The section #{@section.name} has been deleted successfully"
      redirect_to(sections_path)
    else
      flash[:error] = "There is an error when trying to delete the section #{@section.name}."
      render('delete')
    end

  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
