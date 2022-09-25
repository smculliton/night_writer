require './lib/braille_library'
require './lib/braille_translator'

class BrailleReader < BrailleTranslator

  include BrailleLibrary

  def message_length
    translate_to_english.length
  end

  def open_file(filepath = message_path)
    file = File.open(filepath)
    @message = file.readlines.map(&:chomp)
    file
  end

  def translate_to_english(braille_array = message)
    braille_array = remove_line_breaks(braille_array) if braille_array.length > 3
    braille_array = braille_array.map { |row| split_row_into_letters(row) }.transpose
    braille_array.map { |letter| braille_library.key(letter) }.join
  end

  def split_row_into_letters(row)
    letters = []
    row.chars.each_slice(2) { |letter| letters << letter }
    letters.map(&:join)
  end

  def remove_line_breaks(braille_array)
    braille_array.delete('')
    array = []
    braille_array.each_slice(3) { |tuple| array << tuple }
    array.transpose.map(&:join)
  end
end