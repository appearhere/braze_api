# frozen_string_literal: true

module BrazeAPI
  module Endpoints
    module Users
      # Methods to call the users/delete endpoint from a client instance
      module Delete
        PATH = '/users/delete'

        # The main method calling the endpoint.
        # Called with an object containing optional keys of
        # external_ids, user_aliases, braze_ids
        # external_ids => optional array of strings
        # braze_ids => optional array of strings
        # user_aliases => optional array of UserAlias objects
        def delete_users(external_ids: [], user_aliases: [], braze_ids: [])
          args = {}
          args[:external_ids] = external_ids unless external_ids.empty?
          args[:braze_ids] = braze_ids unless braze_ids.empty?
          args[:user_aliases] = user_aliases unless user_aliases.empty?
          post(PATH, params: args)
        end
      end
    end
  end
end
