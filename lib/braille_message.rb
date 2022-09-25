class BrailleMessage
  attr_reader :message, :formatted_message

  def initialize(message)
    @message = message
    @formatted_message = []
  end

  def format_message
    remove_line_breaks
    split_into_braille_letters
  end

  def split_into_braille_letters
    @formatted_message.map { |row| split_row_into_letters(row) }.transpose
  end

  def split_row_into_letters(row)
    letters = []
    row.chars.each_slice(2) { |letter| letters << letter }
    letters.map(&:join)
  end

  def remove_line_breaks
    @message.delete('')
    @message.each_slice(3) { |tuple| @formatted_message << tuple }
    @formatted_message = @formatted_message.transpose.map(&:join)
  end
end