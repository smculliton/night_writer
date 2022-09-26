require './lib/character'
require './lib/message'

class BrailleMessage < Message
  def create_message_array
    @message.map { |char| Character.new(char) }
  end

  def message_length
    @message_array.length
  end
end