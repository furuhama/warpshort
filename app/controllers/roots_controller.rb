# frozen_string_literal: true

class RootsController < ApplicationController
  before_action :set_url, only: %i[show]

  def show
  end

  private

  def set_url
    @url = Url.new
  end
end
