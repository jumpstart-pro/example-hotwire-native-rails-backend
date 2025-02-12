module API
  module V1
    class AuthsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:destroy]

      def destroy
        current_user.notification_tokens
          .find_by(token: params[:notification_token])&.destroy
        sign_out(current_user)
        render json: {}
      end
    end
  end
end
