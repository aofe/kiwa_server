class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:go_offline, :go_online]

  # A list of all the entities in the database
  # Used for offline mode searching using the browser's "find" function
  def offline_index
  end

  # This action provides a start point for the site export
  # and provides an in-page link to the url defined by params[:start_url].
  # This allows us to provide params to a page put the session into
  # offline mode and then provide a link to the first page. The entry
  # page with the offline mode session params can then be deleted
  def go_offline
    raise "Uh uh uh, you didn't say the magic word" unless params[:offline_key] == ENV['KIWA_OFFLINE_KEY']
    session[:offline] = true
    render :layout => false
  end

  def go_online
    session.delete(:offline)
    redirect_to root_url
  end
end