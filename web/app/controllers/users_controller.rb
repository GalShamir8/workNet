# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.where(company: current_company).excluding(current_user)
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date)
  end
end
