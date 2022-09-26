require './lib/character'

class Message
  attr_reader :message, :message_array

  def initialize(message)
    @message = message
    @message_array = create_message_array
  end

  def create_message_array
    @message.map do |row|
      row.chars.map { |char| Character.new(char) }
    end
  end
end