require 'spec_helper'

RSpec.describe BloomRemit2::Recipient do
  describe '.list' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'returns a list of Recipients', { vcr: { record: :once, match_requests_on: %i[method] } } do
      recipients = described_class.list('aeaba496-292b-49d4-bacb-efb41be96d9f')
      expect(recipients).to be_an Array
    end
  end
  describe '.create' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'creates a Recipient', { vcr: { record: :once, match_requests_on: %i[method] } } do
      recipient = described_class.create(
        'aeaba496-292b-49d4-bacb-efb41be96d9f',
        {
          first_name: 'Hello',
          last_name: 'Tester',
          email: 'hellotester@example.com',
          mobile: '639171234567',
          address: '1025 Roxas Boulevard',
          city: 'Makati City',
          province: 'Metro Manila',
          country: 'PH'
        }
      )
      expect(recipient).to be_a BloomRemit2::Recipient
    end
  end
  describe '.retrieve' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'retrieves a Recipient', { vcr: { record: :once, match_requests_on: %i[method] } } do
      recipient = described_class.retrieve(
        'aeaba496-292b-49d4-bacb-efb41be96d9f',
        'a114cf5a-40ba-40a9-9e4e-4cb8e7cdad45'
      )
      expect(recipient).to be_a BloomRemit2::Recipient
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
      recipient = described_class.update(
        'aeaba496-292b-49d4-bacb-efb41be96d9f',
        'a114cf5a-40ba-40a9-9e4e-4cb8e7cdad45',
        { first_name: 'Bye' }
      )
      expect(recipient).to be_a BloomRemit2::Recipient
      expect(recipient.first_name).to eq 'Bye'
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
      recipient = described_class.delete(
        'aeaba496-292b-49d4-bacb-efb41be96d9f',
        'a114cf5a-40ba-40a9-9e4e-4cb8e7cdad45',
      )
      expect(recipient).to be_a BloomRemit2::Recipient
      expect(recipient.sender_id).to eq 'aeaba496-292b-49d4-bacb-efb41be96d9f'
      expect(recipient.id).to eq 'a114cf5a-40ba-40a9-9e4e-4cb8e7cdad45'
      expect(recipient.deleted).to eq true
    end
  end
end
