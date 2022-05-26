# frozen_string_literal: true

RSpec.describe BrazeAPI::Endpoints::SubscriptionGroups::StatusGet do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:email) { 'hello@appearhere.co.uk' }
  let(:phone) { '+440000000000' }
  let(:external_id) { '12314es5' }
  let(:subscription_group_id) { '12' }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:get).and_return('success') }

  describe '.status' do
    it 'gets the subscription status with an external id and subscription_group_id' do
      expect(subject)
        .to receive(:get)
        .with(
          '/subscription/status/get',
          params: {
            external_id: external_id,
            subscription_group_id: subscription_group_id,
          }
        )

      subject.status(
        external_id: external_id,
        subscription_group_id: subscription_group_id,
      )
    end

    it 'gets the subscription status with an email and subscription_group_id' do
      expect(subject)
        .to receive(:get)
        .with(
          '/subscription/status/get',
          params: {
            email: email,
            subscription_group_id: subscription_group_id,
          }
        )

      subject.status(
        email: email,
        subscription_group_id: subscription_group_id,
      )
    end

    it 'gets the subscription status with a phone and subscription_group_id' do
      expect(subject)
        .to receive(:get)
        .with(
          '/subscription/status/get',
          params: {
            phone: phone,
            subscription_group_id: subscription_group_id,
          }
        )

      subject.status(
        phone: phone,
        subscription_group_id: subscription_group_id,
      )
    end
  end
end
