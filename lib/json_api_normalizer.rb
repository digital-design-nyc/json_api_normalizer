require 'json_api_normalizer/parser'

module JsonApiNormalizer
  def self.parse(payload)
    Parser.parse(payload)
  end
end
