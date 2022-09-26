require './lib/message'
require './lib/modules/formattable'

class Translator
  attr_reader :message, :message_length

  include Formattable

  def initialize(message)
    @message_length = message.length
    @message = Message.new(add_line_breaks(message))
  end

  def translate_english_to_braille
    translation = @message.message_array.map do |row|
      row.map(&:to_braille)
    end
    
    format_braille_to_write_to_file(translation).chomp
  end
end
