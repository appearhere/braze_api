module BrazeAPI
  module Endpoints
    module Users
      # Methods to call the users/export endpoint from a client instance
      module Export
        PATH = '/users/export/ids'.freeze
        # The main method calling the endpoint.
        # Called with an email, array of external_ids,
        # and the fields that you wish to export data on.
        # can only search by one email at a time, but can search with multiple ids
        def export_users(email: nil, external_ids: [], fields_to_export: [])
          body = {}.tap do |b|
            b[:external_ids] = external_ids unless external_ids.empty?
            b[:email_address] = email if email && external_ids.empty?
            b[:fields_to_export] = fields_to_export unless fields_to_export.empty?
          end
          post(
            PATH,
            params: body
          )
        end
      end
    end
  end
end
