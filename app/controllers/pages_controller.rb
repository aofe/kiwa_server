class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:go_offline, :go_online]

  # A list of all the entities in the database
  # Used for offline mode searching using the browser's "find" function
  def offline_index
  end
end