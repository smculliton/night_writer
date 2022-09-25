require './lib/braille_library'
require './lib/night_translator'

class NightWriter < NightTranslator
  attr_reader :message_path, :write_path, :message

  include BrailleLibrary

  def translate_braille(string = message)
    translation = []
    3.times { |i| translation << braille_row(string, i) }
    translation = row_splitter(translation)
    translation.join("\n")
  end

  def braille_row(string, row)
    string.chars.map { |letter| braille_library[letter][row] }.join
  end
  
  def row_splitter(translation)
    return translation if translation.none? { |row| row.length > 80 }

    translation << ''
    translation.select { |row| row.length > 80 }.each do |row|
      # edge case - somehow two rows of braille are exactly identical

      translation[translation.index(row)] = row[0..79]
      translation << row[80..row.length]
    end

    row_splitter(translation)
  end

  def insert_line_breaks(array)
    array.each_with_index { |element, index| array.insert(index, '') if index % 4 == 0 }.shift
    array
  end
end
