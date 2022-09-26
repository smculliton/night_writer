require './lib/message'

class Translator
  attr_reader :message

  def initialize(message)
    @message = Message.new(message)
  end

  def translate_english_to_braille
    message.create_message_array

    translation = message.message_array.group_by do |character| 
      message.message_array.index(character) / 40
    end
    
    translation.transform_values! do |chars| 
      chars.map(&:to_braille).transpose.map(&:join)
    end
    
    translation.values.map { |row| row.join("\n") }.join("\n\n")
  end

  def message_length
    @message.message_length
  end
end
