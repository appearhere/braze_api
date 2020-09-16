require 'time'
module BrazeAPI
  module Endpoints
    module Users
      # Methods to call the users/track endpoint from a client instance
      module Track
        PATH = '/users/track'.freeze

        # The main method calling the endpoint.
        # Called with an object containing multiple events and/or purchases and attributes.
        def track(args = {})
          args[:events] = add_time_and_app_id(args[:events]) if args[:events]
          args[:purchases] = add_time_and_app_id(args[:purchases]) if args[:purchases]
          post(PATH, params: args)
        end

        # If you would like to track a single event object
        def track_event(event)
          track(events: [event])
        end

        # If you would like to track a single purchase object
        def track_purchase(purchase)
          track(purchases: [purchase])
        end

        # If you would like to track a single attribute object
        def track_attribute(attribute)
          track(attributes: [attribute])
        end

        private

        # Adds the time (mandatory for events and purchases) and the app id
        def add_time_and_app_id(events)
          events.map { |event| event.merge!(time: Time.now.iso8601, app_id: app_id) }
        end
      end
    end
  end
end
