require './lib/modules/braille_library'
require './lib/braille_translator'
require './lib/braille_message'

class BrailleWriter < BrailleTranslator

  include BrailleLibrary

  # def translate_braille(string = message)
  #   translation = []
  #   3.times { |i| translation << create_braille_row(string, i) }
  #   translation = row_splitter(translation) unless translation.none? { |row| row.length > 80 }
  #   translation = insert_line_breaks(translation)
  #   translation.join("\n").chomp
  # end

  def translate_braille(string = message)
    translation = []
    3.times { |i| translation << create_braille_row(string, i) }
    BrailleMessage.new(translation).format_message_to_write
  end

  def create_braille_row(string, row)
    string.chars.map { |letter| braille_library[letter][row] }.join
  end
  
  # def row_splitter(translation)
  #   translation.map { |row| split_row(row) }.transpose.flatten
  # end

  # def split_row(row)
  #   row.chars.each_slice(80).to_a.map(&:join)
  # end

  # def insert_line_breaks(array)
  #   array.each_with_index { |element, index| array.insert(index, '') if index % 4 == 0 }.shift
  #   array
  # end
end
