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
    render :nothing => true, :status => 403 unless current_user.can_download

    SiteExporter.export(offline_title_project_url(params[:id], :host => "localhost", :port => ENV['KIWA_OFFLINE_SERVER_PORT']),
      :full_size_photos => true,
      :recursion_depth => 2,
      :offline_host => "localhost:#{ENV['KIWA_OFFLINE_SERVER_PORT']}",
      :online_host => 'aofe.maa.cam.ac.uk:3000',
      :output_path => "../exports/project_#{params[:id]}",
      :title_page => offline_title_project_path(params[:id]),
      :zipfile => "../exports/project_#{params[:id]}.zip")

    # Stream the file immediately so we can delete it after
    send_data File.open("../exports/project_#{params[:id]}.zip").read, :type => 'application/zip', :filename => "project_#{params[:id]}.zip"
    File.delete("../exports/project_#{params[:id]}.zip")
  end

  def offline_title
    @project = resource
  end

  private

  def authorize_owner!
    raise "Access Denied" unless resource.user == current_user
  end

  def authorize_viewer!
    raise "Access Denied" unless resource.public? || resource.user == current_user
  end
end
