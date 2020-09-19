require 'spec_helper'

RSpec.describe BloomRemit2::Agent do
  describe '.list' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'returns a list of Agents', { vcr: { record: :once, match_requests_on: %i[method] } } do
      agents = described_class.list
      expect(agents).to be_an Array
    end
  end
  describe '.retrieve' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'retrieves an Agent', { vcr: { record: :once, match_requests_on: %i[method] } } do
      agent = described_class.retrieve('91865374-af28-4c3d-b3a8-0b0d9a0e6d42')
      expect(agent).to be_a BloomRemit2::Agent
      expect(agent.id).to be_a String
      expect(agent.name).to be_a String
    end
  end
  describe '.create' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'creates an Agent', { vcr: { record: :once, match_requests_on: %i[method] } } do
      agent = described_class.create('Sample Agent 20200919')
      expect(agent).to be_a BloomRemit2::Agent
      expect(agent.id).to be_a String
      expect(agent.name).to be_a String
    end
  end
  describe '.delete' do
    before do
      BloomRemit2.configure do |c|
        c.api_token = CONFIG[:api_token]
        c.api_secret_key = CONFIG[:api_secret_key]
      end
    end
    it 'deletes an Agent', { vcr: { record: :once, match_requests_on: %i[method] } } do
     agent = described_class.delete('4acebc4c-5f8a-4c2d-83ee-27143d5c2509')
     expect(agent).to be_a BloomRemit2::Agent
     expect(agent.id).to be_a String
     expect(agent.name).to be_nil
     expect(agent.deleted).to eq true
    end
  end
end
