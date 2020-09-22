# frozen_string_literal: true

module BrazeAPI
  module Endpoints
    module Users
      # Methods to call the users/identify endpoint from a client instance
      module Identify
        PATH = '/users/identify'
        # The main method calling the endpoint.
        # Called with an object containing the user alias object
        # and the external id of the user being identified.
        def identify(user_alias:, external_id:)
          post(
            PATH,
            params: { aliases_to_identify: [
              {
                external_id: external_id,
                user_alias: user_alias
              }
            ] }
          )
        end
      end
    end
  end
end
