# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_internal_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  end

  protected

  def render_success(data, status = :ok)
    render json: { success: true, data: }, status:
  end

  def render_error(message, status = :bad_request)
    error_response = build_error_response(message, status)
    render json: error_response, status:
  end

  private

  def build_error_response(message, status)
    if message.is_a?(Hash)
      {
        success: false,
        error: {
          code: status_to_error_code(status),
          message: 'Validation failed',
          details: message
        }
      }
    else
      {
        success: false,
        error: {
          code: status_to_error_code(status),
          message: message.to_s
        }
      }
    end
  end

  def status_to_error_code(status)
    {
      unprocessable_entity: 'VALIDATION_ERROR',
      unauthorized: 'UNAUTHORIZED',
      forbidden: 'FORBIDDEN',
      not_found: 'NOT_FOUND',
      bad_request: 'BAD_REQUEST',
      internal_server_error: 'INTERNAL_ERROR'
    }[status.to_sym] || 'ERROR'
  end

  def render_not_found(_exception)
    render_error 'Resource not found', :not_found
  end

  def render_bad_request(exception)
    render_error exception.message, :bad_request
  end

  def render_unprocessable_entity(exception)
    render_error exception.message, :unprocessable_entity
  end

  def render_internal_error(exception)
    Rails.logger.error(
      "Internal Error: #{exception.message}\n#{exception.backtrace.join("\n")}"
    )
    render_error 'Internal server error', :internal_server_error
  end
end
