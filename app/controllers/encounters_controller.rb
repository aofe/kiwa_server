class EncountersController < GlintSearchController
  include EncountersHelper

  protected

  def resource_name
    'encounter'
  end

  def klass
    encounter_type
  end

  def autocomplete_options
    super.merge(:except => :type)
  end

  def default_order
    :accession_number
  end
end