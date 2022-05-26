# frozen_string_literal: true

module BrazeAPI
  module Endpoints
    module SubscriptionGroups
      # Methods to call the subscription/status endpoint from a client instance
      module StatusGet
        PATH = '/subscription/status/get'
        # The method to get a user subscription status
        # Args object will look like:
        # {subscription_group_id: id, external_id: uuid}
        # with either an external_id or an email or a phone
        # and subscription group id
        def status(args = {})
          args.compact!
          get(PATH, params: args)
        end
      end
    end
  end
end
