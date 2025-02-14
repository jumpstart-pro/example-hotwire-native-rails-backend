class ApplicationController < ActionController::Base
  before_action if: ->{ devise_controller? && hotwire_native_app? } do
    request.env["warden"].params["hotwire_native_form"] = true
  end

  def after_sign_in_path_for(resource_or_scope)
    return "/reset_app" if hotwire_native_app?
    stored_location_for(resource_or_scope) || super
  end
end
