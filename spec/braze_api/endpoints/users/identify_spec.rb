# frozen_string_literal: true

RSpec.describe BrazeAPI::Endpoints::Users::Identify do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:user_alias) { { alias_name: 'hello@appearhere.co.uk', alias_label: 'email' } }
  let(:external_id) { '12314es5' }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:post).and_return('success') }

  describe '.identify' do
    it 'creates a user alias' do
      expect(subject)
        .to receive(:post)
        .with(
          '/users/identify',
          params: { aliases_to_identify: [{ external_id: external_id, user_alias: user_alias }] }
        )

      subject.identify(user_alias: user_alias, external_id: external_id)
    end
  end
end
