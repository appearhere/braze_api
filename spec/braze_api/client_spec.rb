RSpec.describe BrazeAPI::Client do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:client) { described_class.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_client) do
    Faraday.new do |b|
      b.use BrazeAPI::Response::RaiseError
      b.adapter(:test, stubs)
    end
  end
  let(:post_body) { { events: [{ external_id: '1A-dasfdf', name: 'Test Event' }] } }

  before { allow(client).to receive(:client).and_return(test_client) }

  after(:each) { Faraday.default_connection = nil }

  it 'sets up a client instance' do
    expect(client.send(:api_key)).to be(api_key)
    expect(client.send(:app_id)).to be(app_id)
    expect(client.send(:braze_url)).to be(braze_url)
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
      response = client.post('test/endpoint', params: post_body)
      expect(response['message']).to eq('success')
    end

    it 'handles 400' do
      stubs.post('test/endpoint', post_body.to_json) do
        [
          400,
          { 'Content-Type': 'application/json' },
          { message: 'Bad Request' }.to_json
        ]
      end
      expect { client.post('test/endpoint', params: post_body) }
        .to raise_error(BrazeAPI::Errors::BadRequest, 'Bad Request')
    end

    it 'handles 401' do
      stubs.post('test/endpoint', post_body.to_json) do
        [
          401,
          { 'Content-Type': 'application/json' },
          { message: 'Unauthorized' }.to_json
        ]
      end
      expect { client.post( 'test/endpoint', params: post_body) }
        .to raise_error(BrazeAPI::Errors::Unauthorized)
    end

    it 'handles 404' do
      stubs.post('test/endpoint', post_body.to_json) do
        [
          404,
          { 'Content-Type': 'application/json' },
          { message: 'Not Found' }.to_json
        ]
      end
      expect { client.post( 'test/endpoint', params: post_body) }
        .to raise_error(BrazeAPI::Errors::NotFound, 'Not Found')
    end

    it 'handles 429' do
      stubs.post('test/endpoint', post_body.to_json) do
        [
          404,
          { 'Content-Type': 'application/json' },
          { message: 'Rate Limited' }.to_json
        ]
      end
      expect { client.post( 'test/endpoint', params: post_body) }
        .to raise_error(BrazeAPI::Errors::NotFound, 'Rate Limited')
    end
  end
end
