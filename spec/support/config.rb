config = YAML.load_file(SPEC_DIR.join('config.yml')).with_indifferent_access
if api_token = ENV['BLOOM_REMIT_API_TOKEN'].presence
  config[:api_token] = api_token
end
if secret_key = ENV['BLOOM_REMIT_API_SECRET_KEY'].presence
  config[:api_secret_key] = secret_key
end
CONFIG = config
