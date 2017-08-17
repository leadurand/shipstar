class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :store_current_location, unless: :devise_controller?

  add_flash_types :search_error


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :specie_id, :planet_id])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :specie, :planet])
  end

private

  def store_current_location
    return unless request.get?
    store_location_for(:user, request.url)
  end
end
