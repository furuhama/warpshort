# frozen_string_literal: true

require 'digest'

class Url
  class Generator
    include ActiveModel::Model

    attr_reader :direction, :hashed_value

    def initialize(url)
      @direction = url
      @hashed_value = Digest::MD5.base64digest url
    end

    def generate
      url = Url.new(to_hash)

      if url.valid?
        # NOTE: valid でかつ永続化に失敗する場合
        # 予期せぬ状態になることが考えられるので例外を投げる
        url.save!
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
