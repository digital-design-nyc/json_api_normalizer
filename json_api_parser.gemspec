$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "json_api_parser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "json_api_parser"
  spec.version     = JsonApiParser::VERSION
  spec.authors     = ["Ivan Rudskikh"]
  spec.email       = ["shredder.rull@gmail.com"]
  spec.homepage    = 'https://github.com/digital-design-nyc/json_api_parser'
  spec.summary     = 'Simple json api parser'
  spec.description = 'Simple json api parser'
  spec.license     = "MIT"

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_development_dependency 'rspec', '>= 2.0'
end
