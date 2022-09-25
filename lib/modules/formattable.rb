module Formattable
  
  # formatting braille to be translated
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

  # formatting braille to write to a file
  def split_into_rows
    @formatted_message = @message.map { |row| split_row(row) }.transpose.flatten
  end

  def split_row(row)
    row.chars.each_slice(80).to_a.map(&:join)
  end

  def insert_line_breaks
    @formatted_message.each_with_index { |element, index| @formatted_message.insert(index, '') if index % 4 == 0 }.shift
    @formatted_message.join("\n").chomp
  end
end