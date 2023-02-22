class Api::V1::ProjectsController < ApplicationController
  def index
    projects = Project.all
    render json: projects
  end

  def show
    project = Project.find(params[:id])
    render json: project
  end

  def create
    project = Project.new(project_params)

    if project.save
      render json: project
    else
      render json: { error: project.errors.messages }, status: 422
    end
  end

  def update
    project = Project.find(params[:id])

    if project.update(project_params)
      render json: project
    else
      render json: { error: project.errors.messages }, status: 422
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    head :no_content
  end

  private

  def project_params
    params.require(:project).permit(:title, :tech_stack, :background_image, :images, :source, :live, :description)
  end
end
