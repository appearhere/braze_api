# v0.1.4

- **BREAKING** Previous `BrazeAPI::Endpoints::SubscriptionGroups::Status` module has been renamed to `BrazeAPI::Endpoints::SubscriptionGroups::Status::Update`
- Adds support to list all subscription groups for a user via `BrazeAPI::Endpoints::SubscriptionGroups::Status::List#statuses`
- Adds support to get subscription group status for a user via `BrazeAPI::Endpoints::SubscriptionGroups::Status::Get#status`

# v0.1.3

- **BREAKING** Updates ruby version to 2.7, rubocop to 1.0, and dependencies.
- Fixes security vulnerabilities.

# v0.1.2

- Adds method to delete users.

# v0.1.1

- Update faraday dependency to v0.15