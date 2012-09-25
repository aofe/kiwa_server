class ApplicationController < ActionController::Base
  include UserPreferences
  
  protect_from_forgery
  
  before_filter :authenticate_user!, :update_preferences_from_params

  class AccessDenied < StandardError; end

# HACK: Ensure the Voyage and Encounter searches classe have been dynamically created in development mode
  Voyage
  Encounter
  Person
  Expedition
  Location
  Inventory
  Label
  Card
end