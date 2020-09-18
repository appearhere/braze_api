RSpec.describe BrazeAPI::Endpoints::Users::Export do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:external_ids) { %w(12314es5 23r2352f 124234f) }
  let(:email) { 'hello@appearhere.co.uk' }
  let(:fields_to_export) { %w(custom_attributes custom_events) }
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:post).and_return('success') }

  describe '.export_users' do
    context 'when external ids are provided' do
      it 'exports a list of users' do
        expect(subject)
          .to receive(:post)
          .with(
            '/users/export/ids',
            params: { external_ids: external_ids }
          )

        subject.export_users(external_ids: external_ids)
      end

      it 'sends the fields to export' do
        expect(subject)
          .to receive(:post)
          .with(
            '/users/export/ids',
            params: { external_ids: external_ids, fields_to_export: fields_to_export }
          )

        subject.export_users(external_ids: external_ids, fields_to_export: fields_to_export)
      end
    end

    context 'when an email is provided' do
      it 'exports a list of users by email' do
        expect(subject)
          .to receive(:post)
          .with(
            '/users/export/ids',
            params: { email_address: email }
          )

        subject.export_users(email: email)
      end
    end
  end
end
