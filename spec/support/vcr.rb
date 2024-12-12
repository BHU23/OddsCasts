require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true 
  config.filter_sensitive_data('<api_key>') { Rails.application.credentials.tmdb_api_key }
end
