require 'spec_helper'

RSpec.describe BloomRemit2::Sender do
  describe '.list' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'returns a list of Senders', { vcr: { record: :once, match_requests_on: %i[method] } } do
      senders = described_class.list
      expect(senders).to be_an Array
    end
  end
  describe '.create' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'creates a Sender', { vcr: { record: :once, match_requests_on: %i[method] } } do
      sender = described_class.create(
        {
          agent_id: '9e7d651f-d94c-42a2-824c-a2413796c2fb',
          sender: {
            first_name: 'Hello',
            last_name: 'Tester',
            email: 'hellotester@example.com',
            mobile: '+639175551111',
            address: '251 Salcedo St., Legaspi Village',
            city: 'Makati City',
            country: 'PH',
            postal_code: '1600'
          }
        }
      )
      expect(sender).to be_a BloomRemit2::Sender
    end
  end
  describe '.retrieve' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'retrieves a Sender', { vcr: { record: :once, match_requests_on: %i[method] } } do
      sender = described_class.retrieve('46572a31-a85a-41a5-a45f-bb5518f47340')
      expect(sender).to be_a BloomRemit2::Sender
    end
  end
  describe '.find_by_email', { vcr: { record: :once, match_requests_on: %i[method] } } do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'finds a sender by their email', { vcr: { record: :once, match_requests_on: %i[method] } } do
      sender = described_class.find_by_email('hellotester@example.com')
      expect(sender).to be_a BloomRemit2::Sender
    end
  end
  describe '.update' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'updates a Sender', { vcr: { record: :once, match_requests_on: %i[method] } } do
      sender = described_class.update(
        '46572a31-a85a-41a5-a45f-bb5518f47340',
        { first_name: 'Bye' }
      )
      expect(sender).to be_a BloomRemit2::Sender
      expect(sender.first_name).to eq 'Bye'
    end
  end
  describe '.delete' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'deletes a Sender', { vcr: { record: :once, match_requests_on: %i[method] } } do
      sender = described_class.delete('46572a31-a85a-41a5-a45f-bb5518f47340')
      expect(sender).to be_a BloomRemit2::Sender
      expect(sender.id).to eq '46572a31-a85a-41a5-a45f-bb5518f47340'
      expect(sender.deleted).to eq true
    end
  end
end
