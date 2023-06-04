# frozen_string_literal: true

# LinksController
class LinksController < ApplicationController
  before_action :set_link, only: [:destroy]
  def index
    @links = current_company.links
  end

  def new
    @link = current_company.links.build
  end

  def create
    respond_to do |format|
      @link = Link.new(link_params)
      if @link.save
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, alert: 'Failed to create Link' }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Link was successfully deleted.' }
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:company_id, :href, :name)
  end
end
