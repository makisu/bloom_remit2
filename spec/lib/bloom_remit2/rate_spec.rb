require 'spec_helper'

RSpec.describe BloomRemit2::Rate do
  describe '.list' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'returns a real-time hash of currency exchange rates', { vcr: { record: :once, match_requests_on: %i[method] } } do
      rates = described_class.list
      expect(rates).to be_a Hash
    end
  end
  describe '.retrieve' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'retrieves one currency exchange rate', { vcr: { record: :once, match_requests_on: %i[method] } } do
      rate = described_class.retrieve('USDPHP')
      expect(rate).to be_a Hash
      expect(rate['USDPHP']).to be_a Float
    end
  end
end
