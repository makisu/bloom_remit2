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
  describe '.execute', { vcr: { record: :once, match_requests_on: %i[method] } } do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    context 'staging' do
      it 'initiates a new money transfer' do
        remittance = described_class.execute(
          '5c9ed3d8-3a0f-4c0b-9451-ceae340fd863',
          {
            recipient_id: '9f77f253-3033-4247-97ac-249bc084b595',
            remittance: {
              account_name: 'Juan Dela Cruz',
              account_number: '1234567890',
              dest_currency: 'PHP',
              flat_fee_in_orig_currency: 0,
              forex_margin: 0,
              orig_currency: 'PHP',
              payout_method: 'BPI',
              receivable_in_dest_currency: 25000
            }
          },
          staging: true
        )
        expect(remittance).to be_a BloomRemit2::Remittance
      end
    end
  end
end
