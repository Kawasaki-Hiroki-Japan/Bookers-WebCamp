# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name profile_image email postal_code prefectures city street building])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name])
  end

  def correct_user?(user)
    return false if current_user.nil?

    user.id.equal?(current_user.id)
  end
end
