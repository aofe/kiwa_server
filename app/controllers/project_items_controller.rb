class ProjectItemsController < ApplicationController
  inherit_resources

  def create    
    current_user.projects.find(params[:project_item][:project_id]).project_items.create(params[:project_item])
    respond_to do |format|
      format.js {render :nothing => true}
    end
  end

  def update
    project_item = ProjectItem.find(params[:id])
    current_user.projects.find(project_item.project_id) # Check if this project item belongs to the user
    project_item.update_attribute(:note, params[:project_item][:note])
    respond_to do |format|
      format.js {render :nothing => true}
    end
  end

  def show
    redirect_to resource.item
  end

  def autocomplete
    render :json => ProjectItemSearch.new(params[:project_id], params[:q]).autocomplete_tags(:limit => 10)
  end
end
