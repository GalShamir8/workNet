# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user?
  helper_method :admin?
  helper_method :current_company

  def admin?
    current_user.is_admin?
  end

  def current_company
    @current_company ||= current_user.company
  end

  def current_user?(user)
    user == current_user
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
        :role,
        :department_id,
        :company_id,
        :team_id,
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
        :role,
        :department_id,
        :company_id,
        :team_id,
        :profile_pictures
      )
    end
  end
end
