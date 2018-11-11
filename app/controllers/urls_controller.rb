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
    if already_generated_url =  Url.find_by(direction: url_param[:direction])
      return redirect_to root_path, notice: "Here's Warp gate for your direction: #{WarpShort::HOSTNAME + already_generated_url.hashed_value}"
    end

    url_generator = Url::Generator.new(url_param[:direction])

    if url_generator.generate
      redirect_to root_path, notice: "Here's Warp gate for your direction: #{WarpShort::HOSTNAME + url_generator.hashed_value}"
    else
      redirect_to root_path, alert: url_generator.errors.full_messages
    end
  end

  private

  def set_url
    @url = Url.find_by(hashed_value: params[:code])
  end

  def url_param
    params.require(:url).permit(:direction)
  end
end
