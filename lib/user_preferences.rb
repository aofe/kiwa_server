module UserPreferences
  def update_preferences_from_params
    preferences[:view] = params[:view] if params.has_key?(:view)
  end

  def preferences
    session[:preferences] = {} unless session[:preferences].is_a? Hash
    session[:preferences]
  end
end