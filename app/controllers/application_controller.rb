class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource_or_scope)
    return "/reset_app" if hotwire_native_app?
    stored_location_for(resource_or_scope) || super
  end
end
