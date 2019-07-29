require 'spec_helper'

RSpec.describe JsonApiNormalizer do
  it 'returns current version' do
    expect(JsonApiNormalizer::VERSION).to be_a(String)
  end

  let(:output) { described_class.parse(payload).first }

  describe 'Array' do
    let(:payload) { fixture(:articles) }

    it 'has own attributes' do
      expect(output).to include(
        'id' => '1',
        'title' => 'JSON API paints my bikeshed!'
      )
    end

    it 'has relations' do
      expect(output['author']).to match(
        'id' => '9',
        'first-name' => 'Dan',
        'last-name' => 'Gebhardt',
        'twitter' => 'dgeb'
      )
    end

    it 'has deep relations' do
      expect(output['comments'].first).to match(
        'id' => '5',
        'body' => 'First!',
        'author' => {
          'id' => '2',
          'first-name' => 'John',
          'last-name' => 'Travolta',
          'twitter' => 'johnt'
        }
      )
    end
  end

  describe 'Hash' do
    let(:output) { described_class.parse(payload) }
    let(:payload) { fixture(:article) }

    it 'has own attributes' do
      expect(output).to include(
        'id' => '1',
        'title' => 'JSON API paints my bikeshed!'
      )
    end
  end

  describe 'Errors' do
    context 'Payload does not contain required root elements' do
      let(:payload) { {} }
      it 'raise an error' do
        expect { output }.to raise_error(JsonApiNormalizer::InvalidPayloadError)
      end
    end

    context 'Payload contains errors' do
      let(:payload) { fixture(:errors) }
      let(:output) { described_class.parse(payload) }

      it 'returns errors' do
        expect(output).to match(payload)
      end
    end
  end
end
