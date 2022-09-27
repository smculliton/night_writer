require './lib/message'
require './lib/modules/formattable'

class Translator
  attr_reader :message, :message_length

  include Formattable

  def initialize(message)
    @message_length = message.length
    @message = Message.new(format_chars_to_translate(message.delete("\n")))
  end

  def translate_english_to_braille
    translation = @message.message_array.map do |row|
      row.map(&:to_braille)
    end

    format_braille_to_write_to_file(translation).chomp
  end
end
