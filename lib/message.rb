require './lib/character'

class Message
  attr_reader :message, :message_array

  def initialize(message)
    @message = message
    @message_array = ''
  end

  def create_message_array
    @message_array = message.chars.map { |char| Character.new(char) } if message.class == String
    @message_array = message.map { |char| Character.new(char) } if message.class == Array 
  end

  def message_length
    @message_array.length
  end
end