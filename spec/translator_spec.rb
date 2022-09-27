require 'rspec'
require './lib/translator'

RSpec.describe Translator do
  let(:translator) { Translator.new('abc') }

  describe '#initialize' do 
    it 'exists' do 
      expect(translator).to be_a Translator
    end
    it 'has a message in an array with line breaks' do
      expect(translator.message).to be_a Message
      expect(translator.message.message).to eq(["abc\n"])
    end
  end

  describe '#translate_english_to_braille' do 
    it 'translates english into braille' do 
      expected = "O.O.OO\n..O...\n......"
      expect(translator.translate_english_to_braille).to eq(expected)
    end
  end
end
