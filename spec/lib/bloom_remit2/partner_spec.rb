require 'spec_helper'

RSpec.describe BloomRemit2::Partner do
  describe '.retrieve' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'returns a Partner instance', { vcr: { record: :once, match_requests_on: %i[method] } } do
      partner = described_class.retrieve
      expect(partner).to be_an_instance_of(BloomRemit2::Partner)
    end
  end
end
