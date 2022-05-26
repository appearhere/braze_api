# frozen_string_literal: true

module BrazeAPI
  module Endpoints
    module SubscriptionGroups
      # Methods to call the subscription/status endpoint from a client instance
      module Statuses
        PATH = '/subscription/user/status'
        # The method to get a users subscriptions status
        # Args object will look like:
        # {subscription_state: 'subscribed', subscription_group_id: id, external_id: uuid}
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
