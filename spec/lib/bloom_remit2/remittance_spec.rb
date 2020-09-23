require 'spec_helper'

RSpec.describe BloomRemit2::Remittance do
  describe '.list' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'returns a list of remittances', { vcr: { record: :once, match_requests_on: %i[method] } } do
      remittances = described_class.list('aeaba496-292b-49d4-bacb-efb41be96d9f')
      expect(remittances).to be_an Array
    end
  end
  describe '.retrieve' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'retrieves a Remittance', { vcr: { record: :once, match_requests_on: %i[method] } } do
      remittance_id = '131a5554-ccd0-4cc2-a787-c071cb814f92'
      remittance = described_class.retrieve(
        'aeaba496-292b-49d4-bacb-efb41be96d9f',
        '131a5554-ccd0-4cc2-a787-c071cb814f92'
      )
      expect(remittance).to be_a BloomRemit2::Remittance
      expect(remittance.id).to eq remittance_id
      expect(remittance.recipient).to be_a BloomRemit2::Recipient
    end
  end
end
