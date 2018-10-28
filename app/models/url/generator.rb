# frozen_string_literal: true

class Url
  class Generator
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :direction, :string
    attribute :hashed_value, :string

    def initialize(url)
      direction = url
      # TODO: hash 化のロジック実装する
      hashed_value = url
    end

    def generate
      if valid?
        # NOTE: valid でかつ永続化に失敗する場合
        # 予期せぬ状態になることが考えられるので例外を投げる
        Url.create!(to_hash)
      else
        errors.add(:base, 'Failed to generate shorten url')

        false
      end
    end

    def to_hash
      { direction: direction, hashed_value: hashed_value }
    end
  end
end
