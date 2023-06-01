# frozen_string_literal: true

# Override Devise Users::RegistrationsController to be able extend required logic
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :require_admin, only: %i[new]
  prepend_before_action :require_no_authentication, only: %i[create cancel]
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
end
