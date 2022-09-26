require './lib/character'

class Message
  attr_reader :message, :message_array

  def initialize(message)
    @message = message
  end

  def message_array
    message.chars.map { |char| Character.new(char) }
  end
end