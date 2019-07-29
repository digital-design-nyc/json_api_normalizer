require 'json_api_normalizer/errors'

module JsonApiNormalizer
  class Parser
    ROOT_KEYS = %w[data errors].freeze

    attr_reader :payload
    def initialize(payload)
      @payload = payload
      @models = {}
    end

    def parse
      validate_payload

      return payload if payload.key?('errors')

      return normalize(payload['data']) if payload['data'].is_a?(Hash)

      payload['data'].map { |json_model| normalize(json_model) }
    end

    def self.parse(payload)
      new(payload).parse
    end

    private

    def validate_payload
      return unless (ROOT_KEYS & payload.keys).empty?

      raise InvalidPayloadError, "JSON:API document must contain at least one of these objects: #{ROOT_KEYS.join(', ')}"
    end

    def fetch(model, id)
      return @models[model][id] if @models[model] && @models[model][id]

      @models[model] = {} unless @models.key?(model)
      @models[model][id] = normalize(includes[model][id])
    end

    def includes
      @includes ||= payload
                    .fetch('included', [])
                    .group_by { |model| model['type'] }
                    .transform_values do |models|
        models.each_with_object({}) { |model, st| st[model['id']] = model }
      end
    end

    # rubocop: disable Metrics/MethodLength
    def normalize(api_model)
      model = { 'id' => api_model['id'] }.merge!(api_model.fetch('attributes', {}))
      return model unless api_model.key?('relationships')

      api_model['relationships'].each do |relation_name, relation|
        data = relation['data']
        model[relation_name] =
          if data.is_a?(Hash)
            fetch(*data.values_at('type', 'id'))
          else
            data.map { |r| fetch(*r.values_at('type', 'id')) }
          end
      end
      model
    end
    # rubocop: enable Metrics/MethodLength
  end
end
