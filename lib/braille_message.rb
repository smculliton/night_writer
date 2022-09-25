require './lib/modules/formattable'

class BrailleMessage
  attr_reader :message, :formatted_message

  include Formattable

  def initialize(message)
    @message = message
    @formatted_message = []
  end

  def format_message_to_translate
    remove_line_breaks
    split_into_braille_letters
  end

  def format_message_to_write
    split_into_rows
    insert_line_breaks
  end
end