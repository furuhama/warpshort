# frozen_string_literal: true

require 'digest'
require 'uri'

class Url
  # NOTE: Url::Generator は
  #   - ユーザーからの入力値の検証
  #   - db に格納する値の生成
  # を行うクラス
  class Generator
    include ActiveModel::Model

    attr_reader :given_url, :direction, :hashed_value

    def initialize(given_url)
      @given_url = given_url
    end

    def generate
      if given_url.blank?
        errors.add(:base, 'Url cannot be blank')

        return false
      end

      @direction = sanitize_url(given_url)
      @hashed_value = Digest::MD5.base64digest(given_url)

      # NOTE: valid でかつ永続化に失敗する場合
      # 予期せぬ状態になることが考えられるので例外を投げる
      Url.create!(to_hash)

      true
    rescue URI::Error => e
      errors.add(:base, 'Invalid url')

      false
    end

    private

    def sanitize_url(url)
      url = URI.parse(URI.escape(url))

      raise URI::InvalidURIError if url.scheme.nil? || url.host.nil?
      raise URI::InvalidURIError unless url.scheme.in? ['http', 'https']

      url.scheme + url.host + url.port + url.path + url.query
    end

    def to_hash
      { direction: direction, hashed_value: hashed_value }
    end
  end
end
