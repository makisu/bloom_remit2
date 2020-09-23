require 'spec_helper'

RSpec.describe BloomRemit2::Credit do
  describe '.history' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'shows a list of credit transactions', { vcr: { record: :once, match_requests_on: %i[method] } } do
      credits = described_class.history
      expect(credits).to be_an Array
    end
  end
end
