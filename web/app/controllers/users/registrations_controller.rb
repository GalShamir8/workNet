# frozen_string_literal: true

# Override Devise Users::RegistrationsController to be able extend required logic
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :require_admin, only: %i[new]  
  skip_before_action :require_no_authentication

  def update
    super do
      unless params[resource_name][:profile_pictures].nil?
        resource.profile_pictures.attach(params[resource_name][:profile_pictures])
      end
    end
  end

  private

  def require_admin
    return redirect_back fallback_location: root_path if current_user.nil? || !admin?
  end

  def sign_up(_resource_name, _resource)
    flash[:notice] = 'User was successfully created.'
    true
  end
end
