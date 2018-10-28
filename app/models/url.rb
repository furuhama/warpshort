# frozen_string_literal: true

class Url < ApplicationRecord
  validates :direction, presence: true, length: { maximum: 255 }
  validates :hashed_value, presence: true
end
