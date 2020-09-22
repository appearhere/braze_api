# BrazeAPI

The BrazeAPI gem is a Ruby wrapper for the [Braze REST API](https://www.braze.com/docs/api/basics/)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'braze_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install braze_api

## Usage

First you must create a client instance with your api_key, app_id, and braze_url:
```ruby
braze = BrazeAPI::Client.new(api_key: YOUR_API_KEY, app_id: YOUR_APP_ID, braze_url: YOUR_BRAZE_URL)
```
Once you've created your braze instance you can call a number of methods to the endpoints available in the gem:

### Users Track endpoint:

[Track](https://www.braze.com/docs/api/endpoints/user_data/post_user_track/)

```ruby
braze.track(events: [], purchases: [], attributes: [])
```
With this method you can pass multiple event, purchase, and/or attribute objects at once.  It will add a timestamp (current time) and your app_id to the event and purchase objects.

For single tracking objects you can call like:
```ruby
braze.track_event({ external_id: '123', event_name: 'A great event' })
braze.track_purchase({ external_id: '123', product_id: 'Space1', currency: 'GBP', price: 12.50 })
braze.track_attribute({ external_id: '123', first_name: 'Janie' })
```
These methods call `track` with just the single object
- [Event object documentation](https://www.braze.com/docs/api/objects_filters/event_object/#event-object)
- [Purchase object documentation](https://www.braze.com/docs/api/objects_filters/purchase_object/)
- [User Attributes object documentation](https://www.braze.com/docs/api/objects_filters/user_attributes_object/)

### Users Alias Endpoint:

[Alias](https://www.braze.com/docs/api/endpoints/user_data/post_user_alias/)

```ruby
braze.track(alias_name: 'test@email.com', alias_label: 'email')
```
This method creates a user alias in Braze when passed an alias_name and an alias_label.

### Users Identify Endpoint:

[Identify](https://www.braze.com/docs/api/endpoints/user_data/post_user_identify/)

```ruby
braze.identify(user_alias: { alias_name: 'test@email.com', alias_label: 'email' }, external_id: '123')
```
This method identifies an alias user when passed a user alias and an external id.

### Users Export Endpoint:

[Export Users](https://www.braze.com/docs/api/endpoints/export/user_data/post_users_identifier/)

Called with an array of external ids and not passed fields to export will return all fields for each of the users corresponding to the ids.
```ruby
braze.export_users(external_ids: ['123', '345'])
```
Called with an array of external ids and passed fields to export will return only those fields for each of the users corresponding to the ids.
```ruby
braze.export_users(external_ids: ['123', '345'], fields_to_export: ['purchases','email_subscribe'])
```
Called with an email and not passed fields to export will return all fields for each of the users with that email.
```ruby
braze.export_users(email: 'hello@gmail.com')
```

### Subscription Groups Status Set Endpoint:

[Update Status](https://www.braze.com/docs/api/endpoints/subscription_groups/post_update_user_subscription_group_status/)

With this method you can update a user's subscription state for a particular subscription group.  It is called with an email or an external id for an email subscription group, and with a phone number or external id for a push subscription group.
```ruby
braze.update_status(
  external_id: '123',
  subscription_state: 'subscribed',
  subscription_group_id: 'b6dw887f-d8de-456f-345a-fc5ad8734723'
)
# With only an email for an email subscription group
braze.update_status(
  email: 'hello@gmail.com',
  subscription_state: 'subscribed',
  subscription_group_id: 'b6dw887f-d8de-456f-345a-fc5ad8734723'
)
# With only an phone for a push subscription group
braze.update_status(
  phone: '+440000000000',
  subscription_state: 'subscribed',
  subscription_group_id: 'b6dw887f-d8de-456f-345a-fc5ad8734723'
)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/appearhere/braze_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BrazeAPI project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/appearhere/braze_api/blob/master/CODE_OF_CONDUCT.md).
