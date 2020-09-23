require 'spec_helper'

RSpec.describe BloomRemit2 do
  describe '.configure' do
    it 'allows setting of api_token' do
      BloomRemit2.configure { |c| c.api_token = 'my_api_token' }
      expect(BloomRemit2.configuration.api_token).to eq 'my_api_token'
    end

    it 'allows setting of api_secret_key' do
      BloomRemit2.configure { |c| c.api_secret_key = 'my_api_secret_key' }
      expect(BloomRemit2.configuration.api_secret_key).to eq 'my_api_secret_key'
    end
  end
end
