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
    if url = Url.create(direction: url_param[:direction])
      redirect_to root_path, notice: "Here's Warp gate for your direction: #{url.hashed_value}"
    else
      redirect_to root_path, alert: 'Failed to generate shorten url'
    end
  end

  private

  def set_url
    @url = Url.find_by(code: params[:code])
  end

  def url_param
    params.permit(:direction)
  end
end
