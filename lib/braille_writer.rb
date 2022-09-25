require './lib/braille_library'
require './lib/braille_translator'

class BrailleWriter < BrailleTranslator
  attr_reader :message_path, :write_path, :message

  include BrailleLibrary

  def message_length
    message.length
  end

  def translate_braille(string = message)
    translation = []
    3.times { |i| translation << braille_row(string, i) }
    translation = row_splitter(translation) unless translation.none? { |row| row.length > 80 }
    translation = insert_line_breaks(translation)
    translation.join("\n").chomp
  end

  def braille_row(string, row)
    string.chars.map { |letter| braille_library[letter][row] }.join
  end
  
  def row_splitter(translation)
    translation.map { |row| split_row(row) }.transpose.flatten
  end

  def split_row(row)
    row.chars.each_slice(80).to_a.map(&:join)
  end

  def insert_line_breaks(array)
    array.each_with_index { |element, index| array.insert(index, '') if index % 4 == 0 }.shift
    array
  end
end
