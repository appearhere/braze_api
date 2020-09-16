require 'JSON'
require 'braze_api/error'

module BrazeAPI
  # The class that handles the parsing of the response from Braze.
  class ResponseParser
    # Based on the reason phrase in the response determines whether to raise an error
    # or to parse the body of the response.
    def parse(response)
      method_name = response.reason_phrase.gsub(' ', '_').downcase
      return method(method_name).call(response) if respond_to?(method_name, true)

      raise BrazeAPI::Error::InternalServerError, JSON.parse(response.body)['message']
    end

    private

    # If the reason phrase is 'Created' it parses the body of the response
    def created(response)
      JSON.parse(response.body)
    end

    # If the reason phrase is 'Bad Request' raise BrazeAPI::Error::BadRequest with the message
    def bad_request(response)
      raise BrazeAPI::Error::BadRequest, JSON.parse(response.body)['message']
    end

    # If the reason phrase is 'Unauthorized' raise BrazeAPI::Error::Unauthorized
    def unauthorized(_response)
      raise BrazeAPI::Error::Unauthorized
    end

    # If the reason phrase is 'Not Found' raise BrazeAPI::Error::Unauthorized with the message
    def not_found(response)
      raise BrazeAPI::Error::NotFound, JSON.parse(response.body)['message']
    end

    # If the reason phrase is 'Rate Limited' raise BrazeAPI::Error::Unauthorized with the message
    def rate_limited(response)
      raise BrazeAPI::Error::RateLimited, JSON.parse(response.body)['message']
    end
  end
end
