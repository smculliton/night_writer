module Formattable
  def format_braille_to_translate
    translation = []
    @message.delete("")

    translation << @message.select.with_index { |row, index| index % 3 == 0}.join
    translation << @message.select.with_index { |row, index| index % 3 == 1}.join
    translation << @message.select.with_index { |row, index| index % 3 == 2}.join

    translation = translation.map do |array|
      row = []
      array.chars.each_slice(2) do |character|
        row << character.join
      end
      row
    end

    translation.transpose
  end

  def format_braille_to_write_to_file(translation)
    formatted = translation.map { |row| row.transpose.map(&:join) }
    formatted.map { |row| row.join }.join("\n")
  end

  def add_line_breaks(message)
    message.chars.each_slice(40).map { |slice| slice.join.concat("\n") }
  end
end