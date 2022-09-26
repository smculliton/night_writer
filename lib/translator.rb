require './lib/message'

class Translator
  attr_reader :message, :message_length

  def initialize(message)
    @message = Message.new(message)
    @message_length = @message.message_array.length
  end

  def translate_english_to_braille
    translation = message.message_array.map(&:to_braille)
    translation = translation.transpose.map(&:join)
    translation = translation.join("\n")
  end
end
