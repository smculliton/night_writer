require './lib/braille_library'
require './lib/braille_translator'

class BrailleReader < BrailleTranslator
  attr_reader :message_path, :write_path, :message 

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
    original_message = ''
    braille_array = remove_line_breaks(braille_array) if braille_array.length > 3
    (braille_array[0].length / 2).times do |index|
      original_message.concat(braille_library.key(braille_letter(braille_array, index)))
    end
    original_message
  end

  def braille_letter(braille_array, index)
    braille_array.map do |row|
      row[index*2..index*2+1]
    end
  end

  def remove_line_breaks(braille_array)
    braille_array.delete('')
    array = []
    braille_array.each_slice(3) { |tuple| array << tuple }
    array.transpose.map(&:join)
  end
end