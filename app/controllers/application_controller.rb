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

  helper_method :offline_mode?
  def self.offline_mode?
    Rails.env.offline?
  end
  def offline_mode?
    self.class.offline_mode?
  end
  puts "What port is the offline server running on? Set ENV['KIWA_OFFLINE_SERVER_PORT'] or offline site downloads won't work" unless ENV['KIWA_OFFLINE_SERVER_PORT'].present? || offline_mode?
end