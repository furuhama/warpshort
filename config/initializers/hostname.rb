# frozen_string_literal: true

module WarpShort
  HOSTNAME = if Rails.env.development?
               'http://localhost:3000/'.freeze
             else
               '' # TODO: Fill this string with production server hostname
             end
end
