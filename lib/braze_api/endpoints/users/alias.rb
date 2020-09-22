# frozen_string_literal: true

module BrazeAPI
  module Endpoints
    module Users
      # Methods to call the users/alias/new endpoint from a client instance
      module Alias
        PATH = '/users/alias/new'

        # The main method calling the endpoint.
        # Called with an alias name and an alias label.
        def alias(alias_name:, alias_label:)
          post(
            PATH,
            params: {
              user_aliases: [{ alias_name: alias_name, alias_label: alias_label }]
            }
          )
        end
      end
    end
  end
end
