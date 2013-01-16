class ApplicationController < ActionController::Base
  include UserPreferences
  
  protect_from_forgery
  
  before_filter :authenticate_user!, :update_preferences_from_params  
  skip_before_filter :authenticate_user!, :if => :offline_mode?

  class AccessDenied < StandardError; end

# HACK: Ensure the Voyage and Encounter searches classe have been dynamically created in development mode
  ProjectItem
  Voyage
  Encounter
  Person
  Expedition
  Location
  Inventory
  Label
  Card

  raise "You must set an offline mode secret key. Key is read from the environment variable KIWA_OFFLINE_KEY" if ENV['KIWA_OFFLINE_KEY'].blank?
  helper_method :offline_mode?
  def offline_mode?
    session[:offline]
  end
end