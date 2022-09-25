require './lib/braille_library'
require './lib/braille_translator'
require './lib/braille_message'

class BrailleReader < BrailleTranslator

  include BrailleLibrary

  def message_length
    translate_braille_to_english.length
  end

  def open_file(filepath = message_path)
    file = File.open(filepath)
    @message = file.readlines.map(&:chomp)
    file
  end

  def translate_braille_to_english
    braille_message = BrailleMessage.new(message)
    braille_message.format_message.map { |letter| braille_library.key(letter) }.join
  end
end