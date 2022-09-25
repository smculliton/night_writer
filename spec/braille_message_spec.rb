require 'rspec'
require './lib/braille_message'

RSpec.describe BrailleMessage do

  before(:each) do 
    @message = [".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..",
      "0000.0..00..0.......0.00.000.0..0..0....00....0.0....00..000..0000.0..0....0.0..",
      "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..",
      "",
      "000.00",
      ".0.000",
      "..0..."]

    @braille_message = BrailleMessage.new(@message)
  end
  
  describe '#initialize' do
    it 'exists' do 
      expect(@braille_message).to be_a BrailleMessage
    end
    it 'has an unformatted braille message' do 
      expect(@braille_message.message).to eq(@message)
    end
  end

  describe '#remove_line_breaks' do 
    it 'removes line breaks' do 
      expected = [
        ".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..000.00",
        "0000.0..00..0.......0.00.000.0..0..0....00....0.0....00..000..0000.0..0....0.0...0.000",
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000....0...",
      ]
      @braille_message.remove_line_breaks
      expect(@braille_message.formatted_message).to eq(expected)
    end
  end

  describe '#split_into_braille_letters' do 
    before(:each) do 
      @message = ['.00.0.', '0000.0', '0.....']
      @braille_message = BrailleMessage.new(@message)
    end

    it 'splits message into individual braille letters represented in an array' do 
      expected = [['.0', '00', '0.'], ['0.', '00', '..'], ['0.', '.0', '..']]
      @braille_message.remove_line_breaks
      expect(@braille_message.split_into_braille_letters).to eq(expected)
    end
  end

  describe '#split_row_into_letters' do 
    it 'splits a row of braille into component letters' do 
      tested = '0.0.0.0.0....00.0.0.00'
      expect(@braille_message.split_row_into_letters(tested)).to eq(['0.', '0.', '0.', '0.', '0.', '..', '.0', '0.', '0.', '0.', '00'])
    end
  end
end
