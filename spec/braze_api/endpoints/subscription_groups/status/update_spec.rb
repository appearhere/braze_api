# frozen_string_literal: true

RSpec.describe BrazeAPI::Endpoints::SubscriptionGroups::Status::Update do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:email) { 'hello@appearhere.co.uk' }
  let(:external_id) { '12314es5' }
  let(:subscription_group_id) { '12' }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:post).and_return('success') }

  describe '.update_status' do
    it 'updates the subscription status with an external id' do
      expect(subject)
        .to receive(:post)
        .with(
          '/subscription/status/set',
          params: {
            external_id: external_id,
            subscription_group_id: subscription_group_id,
            subscription_state: 'subscribed'
          }
        )

      subject.update_status(
        external_id: external_id,
        subscription_group_id: subscription_group_id,
        subscription_state: 'subscribed'
      )
    end
  end
end
