class ProjectsController < ApplicationController
  inherit_resources

  before_filter :authorize_viewer!, :only => :show
  before_filter :authorize_owner!, :only => [:edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def create
    @project = Project.new(params[:project])
    @project.user = current_user
    @project.save!

    redirect_to @project
    current_user.cry("#{current_user} created a new #{Project.model_name.human}", :subject => @project, :action => :new_project)
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def show
    @project = resource
    @project_items = ProjectItemSearch.new(@project.id, params[:q]).results(:page => params[:page], :order => (params[:q].present? ? :score : :primary_key))
  end

  def export
    SiteExporter.export(project_url(params[:id], :port => 3001),
      :full_size_photos => true,
      :recursion_depth => 1,
      :online_host => 'aofe.maa.cam.ac.uk:3000',
      :output_path => "../exports/project_#{params[:id]}",
      :zipfile => "../exports/project_#{params[:id]}.zip")
    send_file "../exports/project_#{params[:id]}.zip"
  end

  private

  def authorize_owner!
    raise "Access Denied" unless resource.user == current_user
  end

  def authorize_viewer!
    raise "Access Denied" unless resource.public? || resource.user == current_user
  end
end
