require 'rspec'
require './lib/modules/formattable'

RSpec.describe Formattable do 
  let(:dummy_class) { Class.new { extend Formattable } }

  describe '#format_braille_to_translate' do 
    it 'reformats braille from rows into characters' do
      # rows 1, 2, 3 of braille from the .txt file that is three characters long
      tested = ["O.O.O", "..O...", "......"]
      # an array of three braille characters [['a'], ['b'], ['c']]
      expected = [["O.", "..", ".."], ["O.", "O.", ".."], ["O", "..", ".."]]

      expect(dummy_class.format_braille_to_translate(tested)).to eq(expected)
    end 
  end

  describe '#remove_line_breaks' do 
    it 'reconnects separated rows and removes line break row' do 
      tested = ["this is", "here's", "and also", "", " row1", " row2", " row3"]
      expected = ["this is row1", "here's row2", "and also row3"]

      expect(dummy_class.remove_line_breaks(tested)).to eq(expected)
    end
  end

  describe '#split into chars' do 
    it 'splits each row into two character chunks' do 
      tested = ["OO..", "..OO", "OOOO"]
      expected = [["OO", ".."], ["..", "OO"], ["OO", "OO"]]
      
      expect(dummy_class.split_into_chars(tested)).to eq(expected)
    end
  end

  describe '#format_braille_to_write_to_file' do
    it 'takes in an array of braille characters and returns a printable string' do
      # an array of three braille characters and a new line character in one row
       tested = [[["O.", "..", ".."], ["O.", "O.", ".."], ["OO", "..", ".."], ["\n", "\n", "\n"]]]
       # top middle bottom row of printable braille
       expected = "O.O.OO\n..O...\n......\n"

       expect(dummy_class.format_braille_to_write_to_file(tested)).to eq(expected)
    end

    it 'adds a \n character at every line break' do
      tested = [[["O.", "..", ".."], ["\n", "\n", "\n"]], [["O.", "O.", ".."], ["\n", "\n", "\n"]]]
      expected = "O.\n..\n..\n\nO.\nO.\n..\n"
      
      expect(dummy_class.format_braille_to_write_to_file(tested)).to eq(expected)
    end
  end

  describe '#add_line_breaks' do 
    it 'divides string into arrays of 40 characters each and adds \n character' do
      tested = 'the quick brown fox jumps over the lazy dog'
      expected = ["the quick brown fox jumps over the lazy \n", "dog\n"]

      expect(dummy_class.add_line_breaks(tested)).to eq(expected)
    end
  end
end
