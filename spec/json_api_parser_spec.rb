require "spec_helper"

RSpec.describe JsonApiParser do
  it 'returns current version' do
    expect(JsonApiParser::VERSION).to be_a(String)
  end
end