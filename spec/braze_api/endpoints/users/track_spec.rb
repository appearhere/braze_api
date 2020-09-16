RSpec.describe BrazeAPI::Endpoints::Users::Track do
  let(:api_key) { 'abcdefg' }
  let(:app_id) { 'hijklmnop' }
  let(:braze_url) { 'https://rest.fra-01.braze.eu' }
  let(:events) do
    [{
      external_id: '123123',
      name: 'Test Event'
    }, {
      external_id: '3456455',
      name: 'Test Event'
    }]
  end
  let(:attributes) do
    [{
      external_id: '345345',
      first_name: 'Neptune'
    }, {
      external_id: '312345',
      first_name: 'Nova'
    }]
  end
  let(:purchase) do
    {
      external_id: '345345',
      product_id: 'Space12',
      currency: 'GBP',
      price: '$12.50'
    }
  end
  let(:subject) { BrazeAPI::Client.new(api_key: api_key, app_id: app_id, braze_url: braze_url) }
  before { allow(subject).to receive(:post).and_return('success') }

  describe '.track' do
    it 'adds time and app id to events' do
      expect(subject).to receive(:add_time_and_app_id).with(events)

      subject.track(events: events)
    end

    it 'does not add time and app id to attributes' do
      expect(subject).not_to receive(:add_time_and_app_id).with(attributes)

      subject.track(attributes: attributes)
    end

    it 'sends a request to the users track endpoint' do
      expect(subject)
        .to receive(:post)
        .with('/users/track', params: a_hash_including(events: events, attributes: attributes))

      subject.track(events: events, attributes: attributes)
    end
  end

  describe '.track_event' do
    it 'sends a single event to the users track endpoint' do
      expect(subject)
        .to receive(:post)
        .with('/users/track', params: a_hash_including(events: [events.first]))

      subject.track_event(events.first)
    end
  end

  describe '.track_purchase' do
    it 'sends a single purchase to the users track endpoint' do
      expect(subject)
        .to receive(:post)
        .with('/users/track', params: a_hash_including(purchases: [purchase]))

      subject.track_purchase(purchase)
    end
  end

  describe '.track_attribute' do
    it 'sends a single attribute object to the users track endpoint' do
      expect(subject)
        .to receive(:post)
        .with('/users/track', params: {attributes: [attributes.first]})

      subject.track_attribute(attributes.first)
    end
  end
end
