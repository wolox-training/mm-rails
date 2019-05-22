class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale, if: :user_signed_in?

  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

  protected

  def set_locale
    I18n.locale = current_user_locale || I18n.default_locale
  end

  def current_user_locale
    locale = current_user.locale.downcase.to_sym
    I18n.available_locales.include?(locale) ? locale : nil
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name locale])
  end

  private

  def render_record_not_found(invalid)
    render json: { errors: invalid.message }, status: :not_found
  end

  def render_unauthorized(invalid)
    render json: { errors: invalid.message }, status: :unauthorized
  end
end
