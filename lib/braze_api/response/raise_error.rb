# frozen_string_literal: true

module BrazeAPI
  module Response
    # Extends the Faraday RaiseError middleware to handle errors
    class RaiseError < Faraday::Response::RaiseError
      def on_complete(env) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        case env[:status]
        when 400
          raise BrazeAPI::Errors::BadRequest, JSON.parse(response_values(env)[:body])['message']
        when 401
          raise BrazeAPI::Errors::Unauthorized
        when 404
          raise BrazeAPI::Errors::NotFound, JSON.parse(response_values(env)[:body])['message']
        when 429
          raise BrazeAPI::Errors::RateLimited, JSON.parse(response_values(env)[:body])['message']
        when ClientErrorStatuses
          raise BrazeAPI::Errors::InternalServerError,
                JSON.parse(response_values(env)[:body])['message']
        else
          super
        end
      end
    end
  end
end
