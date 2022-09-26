require './lib/braille_message'
require './lib/modules/formattable'

class BrailleTranslator
  attr_reader :message, :message_length

  include Formattable

  def initialize(message)
    @message = message.split("\n")
    @message_length = 0
  end

  def translate_braille_to_english
    new_message = BrailleMessage.new(format_braille_to_translate(@message))
    @message_length = new_message.message_length
    new_message.message_array.map(&:to_character).join
  end
end
