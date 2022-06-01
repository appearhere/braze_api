# frozen_string_literal: true

module BrazeAPI
  module Endpoints
    module SubscriptionGroups
      module Status
        # Methods to call the subscription/status endpoint from a client instance
        module List
          PATH = '/subscription/user/status'
          # The method to get a users subscriptions status
          # Args object will look like:
          # {external_id: uuid, limit: integer, offset: integer}
          # with either an external_id or an email and the subscription state
          # and subscription group id
          def statuses(args = {})
            args.compact!
            get(PATH, params: args)
          end
        end
      end
    end
  end
end
