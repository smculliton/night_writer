require 'rspec'
require './lib/translator'

RSpec.describe Translator do
  let(:translator) { Translator.new('abc') }

  describe '#initialize' do 
    it 'exists' do 
      expect(translator).to be_a Translator
    end
    it 'has a message' do
      expect(translator.message).to be_a Message
      expect(translator.message.message).to eq('abc')
    end
  end

  describe '#translate_english_to_braille' do 
    it 'translates english into braille' do 
      expected = "0.0.00\n..0...\n......"
      expect(translator.translate_english_to_braille).to eq(expected)
    end
  end
end
