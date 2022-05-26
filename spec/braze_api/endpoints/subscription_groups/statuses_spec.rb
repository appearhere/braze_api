# frozen_string_literal: true

RSpec.describe BrazeAPI::Endpoints::SubscriptionGroups::Statuses do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:email) { 'hello@appearhere.co.uk' }
  let(:phone) { '+440000000000' }
  let(:external_id) { '12314es5' }
  let(:subscription_group_id) { '12' }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:get).and_return('success') }

  describe '.statuses' do
    it 'gets the subscriptions statuses with an external id' do
      expect(subject)
        .to receive(:get)
        .with(
          '/subscription/user/status',
          params: {
            external_id: external_id
          }
        )

      subject.statuses(
        external_id: external_id
      )
    end

    it 'gets the subscriptions statuses with an email' do
      expect(subject)
        .to receive(:get)
        .with(
          '/subscription/user/status',
          params: {
            email: email
          }
        )

      subject.statuses(
        email: email
      )
    end

    it 'gets the subscriptions statuses with a phone' do
      expect(subject)
        .to receive(:get)
        .with(
          '/subscription/user/status',
          params: {
            phone: phone
          }
        )

      subject.statuses(
        phone: phone
      )
    end
  end
end
