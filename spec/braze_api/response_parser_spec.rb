RSpec.describe BrazeAPI::ResponseParser do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:connection) { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:post_body) { { events: [{ external_id: '234234sd', name: 'Test Event' }] }.to_json }
  let(:parser) { described_class.new }
  let(:response) { connection.post('test/endpoint', post_body) }

  after(:each) { Faraday.default_connection = nil }

  describe '.parse' do
    context 'api call is successful' do
      it 'returns a success response' do
        stubs.post('test/endpoint', post_body) do
          [
            200,
            { 'Content-Type': 'application/json' },
            { message: 'success' }.to_json
          ]
        end
        allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Created')
        expect(parser.parse(response)).to eq('message' => 'success')
      end
    end

    context 'api call returns an error' do
      it 'raises a Bad Request error' do
        stubs.post('test/endpoint', post_body) do
          [
            400,
            { 'Content-Type': 'application/json' },
            { message: 'Bad Request' }.to_json
          ]
        end
        allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Bad Request')
        expect { parser.parse(response) }.to raise_error(BrazeAPI::Error::BadRequest, 'Bad Request')
      end

      it 'raises a Unauthorized error' do
        stubs.post('test/endpoint', post_body) do
          [
            401,
            { 'Content-Type': 'application/json' },
            { message: 'Invalid API Key' }.to_json
          ]
        end
        allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Unauthorized')
        expect { parser.parse(response) }.to raise_error(BrazeAPI::Error::Unauthorized, 'Invalid API Key')
      end

      it 'raises a Not Found error' do
        stubs.post('test/endpoint', post_body) do
          [
            404,
            { 'Content-Type': 'application/json' },
            { message: 'Not Found' }.to_json
          ]
        end
        allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Not Found')
        expect { parser.parse(response) }.to raise_error(BrazeAPI::Error::NotFound, 'Not Found')
      end

      it 'raises a Rate Limited error' do
        stubs.post('test/endpoint', post_body) do
          [
            429,
            { 'Content-Type': 'application/json' },
            { message: 'Rate Limited' }.to_json
          ]
        end
        allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Rate Limited')
        expect { parser.parse(response) }.to raise_error(BrazeAPI::Error::RateLimited, 'Rate Limited')
      end

      it 'raises an Internal Server error' do
        stubs.post('test/endpoint', post_body) do
          [
            500,
            { 'Content-Type': 'application/json' },
            { message: 'Internal Server Error' }.to_json
          ]
        end
        allow_any_instance_of(Faraday::Response).to receive(:reason_phrase).and_return('Internal Server Error')
        expect { parser.parse(response) }.to raise_error(BrazeAPI::Error::InternalServerError, 'Internal Server Error')
      end
    end
  end
end