# frozen_string_literal: true

# RegistrationsHelper
module Devise::RegistrationsHelper
  def departments_collection
    Department.joins(:users).where(users: { company: current_company }).pluck(:name, :id)
  end
end