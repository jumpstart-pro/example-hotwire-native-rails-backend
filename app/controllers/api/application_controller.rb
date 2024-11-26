module API
  class ApplicationController < ApplicationController
    prepend_before_action :require_api_authentication

    private

    def require_api_authentication
      head :unauthorized unless user_signed_in?
    end
  end
end
