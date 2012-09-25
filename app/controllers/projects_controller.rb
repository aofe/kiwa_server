class ProjectsController < ApplicationController
  inherit_resources

  before_filter :authorize_viewer!, :only => :show
  before_filter :authorize_owner!, :only => [:edit, :update, :destroy]

  def create
    project = Project.create! do |project| 
      project.assign_attributes params[:project]
      project.user = current_user
    end
    redirect_to project
  end

  def show
    @project = resource
    @project_items = ProjectItemSearch.new(@project.id, params[:q]).results(:page => params[:page], :order => (params[:q].present? ? nil : :primary_key))
  end

  private

  def authorize_owner!
    raise "Access Denied" unless resource.user == current_user
  end

  def authorize_viewer!
    raise "Access Denied" unless resource.public? || resource.user == current_user
  end
end
