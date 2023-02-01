# frozen_string_literal: true

# Override Devise Users::RegistrationsController to be able extend required logic 
class Users::RegistrationsController < Devise::RegistrationsController
  def update
    super do
      unless params[resource_name][:profile_pictures].nil?
        resource.profile_pictures.attach(params[resource_name][:profile_pictures])
      end
    end
  end
end
