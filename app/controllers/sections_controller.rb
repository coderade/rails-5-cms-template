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
  end

  def create
    @section = Section.new(section_params)
    @section.save

    if @section.save
      flash[:notice] = 'Section created successfully'
      redirect_to(sections_path)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    if @section.update_attributes(section_params)
      flash[:notice] = 'Section updated successfully.'
      redirect_to(section_path(@section))
    else
      flash[:error] = "There is an error when trying ot delete the section #{@section}. Please try again."
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])

    if @section.destroy
      flash[:notice] = "Section <strong> #{@section.name} </strong> has been deleted successfully"
      redirect_to(sections_path)
    else
      flash[:error] = "There is an error when trying ot delete the section #{@section.name}."
      render('delete')
    end

  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
