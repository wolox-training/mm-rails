class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name locale])
  end

  def render_errors(message, status = :bad_request)
    Rails.logger.error("\nERROR:#{message}\n")
    render json: { errors: message }, status: status
  end

  private

  def render_record_not_found(invalid)
    render json: { errors: invalid.message }, status: :not_found
  end

  def render_unauthorized(invalid)
    render json: { errors: invalid.message }, status: :unauthorized
  end
end
