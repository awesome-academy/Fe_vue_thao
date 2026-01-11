# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ErrorHandler

      before_action :authenticate_request!

      protected

      # Pagination helper method
      def paginate(records, options = {})
        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || options[:per_page] || 10).to_i
        # Ensure reasonable values
        page = 1 if page < 1
        per_page = 1 if per_page < 1
        per_page = 100 if per_page > 100
        # Get total count and paginated records efficiently
        offset = (page - 1) * per_page
        total_count = records.count
        total_pages = (total_count.to_f / per_page).ceil
        paginated_records = records.limit(per_page).offset(offset)
        {
          records: paginated_records,
          pagination: {
            current_page: page,
            per_page: per_page,
            total_count: total_count,
            total_pages: total_pages
          }
        }
      end

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
