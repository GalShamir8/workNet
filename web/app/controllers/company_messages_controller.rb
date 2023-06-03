# frozen_string_literal: true

# CompanyMessagesController
class CompanyMessagesController < ApplicationController
  before_action :set_link, only: [:destroy]

  def index
    @company_messages = fetch_searchable_collection(@service_info) do
      current_company.company_messages
    end
  end

  def new
    @company_message = current_company.company_messages.build
  end

  def create
    respond_to do |format|
      @company_message = CompanyMessage.new(company_message_params)
      if @company_message.save
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company_message.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Message was successfully deleted.' }
    end
  end

  private

  def prepare_service_info
    @service_info = {
      query: params[:query],
      filter: "company_id=#{current_company.id}",
      model_name: 'CompanyMessage'
    }
  end

  def set_link
    @company_message = CompanyMessage.find(params[:id])
  end

  def company_message_params
    params.require(:company_message).permit(:company_id, :content, :title)
  end
end
