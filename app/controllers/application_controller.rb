class ApplicationController < ActionController::Base
  protect_from_forgery
  
#  before_filter :authenticate_user!

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
