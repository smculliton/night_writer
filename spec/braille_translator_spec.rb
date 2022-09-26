require 'rspec'
require './lib/braille_translator'

RSpec.describe BrailleTranslator do
  message = "0.0.00\n..0...\n......"
  let(:translator) { BrailleTranslator.new(message) }

  describe '#initialize' do 
    it 'exists' do 
      expect(translator).to be_a BrailleTranslator
    end
    it 'has a message' do
      expect(translator.message).to eq("0.0.00\n..0...\n......")
    end
  end

  describe '#translate_braille_to_english' do 
    it 'translates braille message into english characters' do 
      expect(translator.translate_braille_to_english).to eq('abc')
    end
  end
end