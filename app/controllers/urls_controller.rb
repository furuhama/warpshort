# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: %i[show]

  def show
    if @url.nil?
      redirect_to root_path, alert: 'Invalid url'
    else
      redirect_to @url.direction
    end
  end

  def create
  end

  private

  def set_url
    @url = Url.find_by(code: params[:code])
  end
end
