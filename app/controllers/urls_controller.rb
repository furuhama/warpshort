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
    url_generator = Url::Generator.new(url_param[:direction])

    if url_generator.generate
      redirect_to root_path, notice: "Here's Warp gate for your direction: #{url_generator.hashed_value}"
    else
      redirect_to root_path, alert: url_generator.errors
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
