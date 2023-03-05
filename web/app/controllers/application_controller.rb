# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin?
    current_user.is_admin?
  end

  protected

  def configure_permitted_parameters
    case action_name
    when 'create'
      configure_sign_up_params
    when 'update'
      configure_account_update_params
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :first_name,
        :last_name,
        :birth_date,
        :email,
        :password,
        :password_confirmation,
        :profile_pictures
      )
    end
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(
        :first_name,
        :last_name,
        :birth_date,
        :email,
        :password,
        :password_confirmation,
        :current_password,
        :profile_pictures
      )
    end
  end
end
