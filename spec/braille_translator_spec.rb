require 'rspec'
require './lib/braille_translator'

RSpec.describe BrailleTranslator do
  message = "O.O.OO\n..O...\n......"
  let(:translator) { BrailleTranslator.new(message) }

  describe '#initialize' do 
    it 'exists' do 
      expect(translator).to be_a BrailleTranslator
    end
    it 'has a message split by lines' do
      expect(translator.message).to eq(["O.O.OO", "..O...", "......"])
    end
  end

  describe '#translate_braille_to_english' do 
    it 'translates braille message into english characters' do 
      expect(translator.translate_braille_to_english).to eq('abc')
    end
  end
end