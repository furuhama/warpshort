# frozen_string_literal: true

class Url
  class Generator
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :url, :string
    attribute :hashed_value, :string

    def generate
      # TODO: hash 化のロジック実装する
      hashed_value = url

      if Url.create(direction: url, hashed_value: hashed_value)
        true
      else
        errors.add(:base, 'Failed to generate shorten url')

        false
      end
    end
  end
end
