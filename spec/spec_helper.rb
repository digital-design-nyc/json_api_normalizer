require 'json_api_normalizer'
require 'pry'

Dir['./spec/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
