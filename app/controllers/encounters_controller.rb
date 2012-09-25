class EncountersController < GlintSearchController

  protected

  def collection
    EncounterSearch.new(params[:encounter_type], params[:q])
  end

  def klass
    Encounter
  end

  def order
    :name
  end

  def autocomplete_options
    super.merge(:except => :type)
  end
end