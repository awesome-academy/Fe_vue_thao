# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ErrorHandler

      before_action :authenticate_request!

      private

      def authenticate_request!
        header = request.headers['Authorization']
        header = header.split.last if header

        begin
          decoded = JWT.decode(header,
                               Rails.application.secrets.secret_key_base)[0]
          @current_user = User.find(decoded['user_id'])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          render_error 'Unauthorized access', :unauthorized
        end
      end
    end
  end
end
