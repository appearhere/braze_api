RSpec.describe BrazeAPI::Client do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:client) { described_class.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_client) { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:post_body) { { events: [{ external_id: '1A-dasfdf', name: 'Test Event' }] } }

  before { allow(client).to receive(:client).and_return(test_client) }

  after(:each) { Faraday.default_connection = nil }

  it 'sets up a client instance' do
    expect(client.api_key).to be(api_key)
    expect(client.app_id).to be(app_id)
  end

  describe '#post' do
    it 'responds to a recognized post method' do
      stubs.post('test/endpoint', post_body.to_json) do
        [
          200,
          { 'Content-Type': 'application/json' },
          { message: 'success' }.to_json
        ]
      end
      allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Created')
      response = client.post('test/endpoint', params: post_body)
      expect(response['message']).to eq('success')
    end
  end
end
