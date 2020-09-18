module BrazeAPI
  module Endpoints
    module SubscriptionGroups
      # Methods to call the subscription/status endpoint from a client instance
      module Status
        PATH = '/subscription/status/set'.freeze
        # The method to update a users subscription status
        # Args object will look like: {subscription_state: 'subscribed', subscription_group_id: id, external_id: uuid}
        # with either an external_id or an email and the subscription state and subscription group id
        def update_status(args = {})
          args.compact!
          post(PATH, params: args)
        end
      end
    end
  end
end
