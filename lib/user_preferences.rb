module UserPreferences
  def update_preferences_from_params
    preferences[:view]                       = params[:view] if params.has_key?(:view)
    preferences[:order][params[:controller]] = params[:order] if params.has_key?(:order)
    preferences[:direction]                  = params[:direction] if params.has_key?(:direction)
  end

  def preferences
    session[:preferences] = {} unless session[:preferences].is_a? Hash
    session[:preferences][:order] = {} unless session[:preferences][:order].is_a? Hash
    return session[:preferences]
  end
end