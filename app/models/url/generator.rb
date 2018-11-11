# frozen_string_literal: true

require 'digest'
require 'uri'

class Url
  class Generator
    include ActiveModel::Model

    attr_reader :direction, :hashed_value

    def initialize(url)
      @given_url = url
    end

    def generate
      if url.nil?
        errors.add(:base, 'Url cannot be blank')

        return false
      end

      @direction = sanitize_url(direction)
      @hashed_value = Digest::MD5.base64digest(url)

      url = Url.new(to_hash)

      # NOTE: valid でかつ永続化に失敗する場合
      # 予期せぬ状態になることが考えられるので例外を投げる
      url.save!

      true
    rescue URI::Error => e
      errors.add(:base, 'Invalid url')

      false
    end

    private

    def sanitize_url(url)
      url = URI.parse(URI.escape(url))

      raise URI::InvalidURIError if url.scheme.nil? || url.host.nil?

      url.scheme + url.host + url.port + url.path + url.query
    end

    def to_hash
      { direction: direction, hashed_value: hashed_value }
    end
  end
end
