# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_service_info, only: :index, if: :searchable_collection?
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

  def fetch_searchable_collection(options)
    if options.nil?
      yield
    else
      Meilisearch::SearchAdapterService.new(query: params[:query], **options).call
    end
  end

  protected

  def searchable_collection?
    params[:query].present? &&
      Object.const_get(controller_name.classify).include?(MeiliSearch::Rails)
  end

  def prepare_service_info
    raise NotImplementedError, 'Method should be implemented in concrete class'
  end

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
        :profile_pictures,
        :is_admin
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
