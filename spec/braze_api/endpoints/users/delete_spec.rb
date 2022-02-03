# frozen_string_literal: true

RSpec.describe BrazeAPI::Endpoints::Users::Delete do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:external_ids) { %w[12314es5 23r2352f 124234f] }
  let(:braze_ids) { %w[a123 b456 c789] }
  let(:user_aliases) { [{user_alias: {alias_name: 'pete', alias_label: 'sampras'}}] }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:post).and_return('success') }

  describe '.delete_users' do
    context 'when external ids are provided' do
      it 'posts to `/users/delete`' do
        expect(subject)
          .to receive(:post)
          .with(
            '/users/delete',
            params: { external_ids: external_ids }
          )

        subject.delete_users(external_ids: external_ids)
      end
    end

    context 'when braze ids are provided' do
      it 'posts to `/users/delete`' do
        expect(subject)
          .to receive(:post)
          .with(
            '/users/delete',
            params: { braze_ids: braze_ids }
          )

        subject.delete_users(braze_ids: braze_ids)
      end
    end

    context 'when user aliases are provided' do
      it 'posts to `/users/delete`' do
        expect(subject)
          .to receive(:post)
          .with(
            '/users/delete',
            params: { user_aliases: user_aliases }
          )

        subject.delete_users(user_aliases: user_aliases)
      end
    end
  end
end
