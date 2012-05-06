class EncountersController < GlintSearchController
  include EncountersHelper # So we can access encounter_type method

  protected

  def collection
    EncounterSearch.new(encounter_type, params[:q])
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