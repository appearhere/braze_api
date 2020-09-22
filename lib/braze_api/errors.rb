# frozen_string_literal: true

module BrazeAPI
  module Errors
    # Error to raise when 400 Bad Request
    class BadRequest < StandardError; end
    # Error to raise when 401 Unauthorized
    class Unauthorized < StandardError
      def message
        'Invalid API Key'
      end
    end
    # Error to raise when 404 Not Found
    class NotFound < StandardError; end
    # Error to raise when 429 Rate Limited
    class RateLimited < StandardError; end
    # Error to raise when 5XX
    class InternalServerError < StandardError; end
  end
end
