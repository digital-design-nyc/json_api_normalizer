require 'singleton'
require 'json'

class Fixtures
  include Singleton

  def initialize
    @fixtures = {}
  end

  def fixture(fixture_name)
    return @fixtures[fixture_name] if @fixtures.key?(fixture_name)

    @fixtures[fixture_name] = JSON.parse(File.read("spec/fixtures/#{fixture_name}.json"))
  end
end

module FixtureMethods
  def fixture(fixture_name)
    Fixtures.instance.fixture(fixture_name)
  end
end

RSpec.configure do |config|
  config.include FixtureMethods
end
