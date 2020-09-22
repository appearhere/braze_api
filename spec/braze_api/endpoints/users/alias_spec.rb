# frozen_string_literal: true

RSpec.describe BrazeAPI::Endpoints::Users::Alias do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:alias_name) { 'hello@appearhere.co.uk' }
  let(:alias_label) { 'email' }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:post).and_return('success') }

  describe '.alias' do
    it 'creates a user alias' do
      expect(subject)
        .to receive(:post)
        .with(
          '/users/alias/new',
          params: { user_aliases: [{ alias_name: alias_name, alias_label: alias_label }] }
        )

      subject.alias(alias_name: alias_name, alias_label: alias_label)
    end
  end
end
