# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = fetch_searchable_collection(@service_info) do
      User.where(company: current_company).excluding(current_user)
    end
  end

  # GET /users/1 or /users/1.json
  def show; end

  private

  def prepare_service_info
    @service_info = {
      query: params[:query],
      filter: "company_id=#{current_company.id}",
      model_name: 'User'
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date)
  end
end
