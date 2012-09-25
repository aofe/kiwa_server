class ProjectItemSearch < Glint::Search
  attr_reader :project_id

  def initialize(project_id, *args)
    @project_id = project_id

    super(*args)
  end
  
  def project
    @project ||= Project.find(@project_id)
  end

  def cache_key
    super("project_id=#{@project_id}")
  end
  
  private

  def scope_results(solr)
    # Automatically limit project items to only those from this project
    solr.with(registered_facet(:project).solr_search_indices[:tag_id], @project_id)
    
    super
  end
end
