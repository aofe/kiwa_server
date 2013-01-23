class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:go_offline, :go_online]

  # A list of all the entities in the database
  # Used for offline mode searching using the browser's "find" function
  def offline_index
  end

  def export_site
    render :nothing => true, :status => 403 unless current_user.can_download

    send_file "../exports/full_site.zip"
  end
end