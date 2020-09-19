require 'gem_config'
require 'bloom_remit2/version'
require 'bloom_remit2/client'
require 'bloom_remit2/partner'
require 'bloom_remit2/agent'

module BloomRemit2
  include GemConfig::Base

  with_configuration do
    has :api_token, classes: String
    has :api_secret_key, classes: String
  end
end
