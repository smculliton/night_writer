module Formattable
  def format_braille_to_translate(message)
    message = remove_line_breaks(message)
    split_into_chars(message).transpose
  end

  def remove_line_breaks(message)
    translation = []
    message.delete("")
    3.times do |i|
      translation << message.select.with_index { |row, index| index % 3 == i}.join
    end
    translation
  end

  def split_into_chars(message)
    message.map do |array|
      row = []
      array.chars.each_slice(2) do |character|
        row << character.join
      end
      row
    end
  end

  def format_braille_to_write_to_file(translation)
    formatted = translation.map { |row| row.transpose.map(&:join) }
    formatted.map { |row| row.join }.join("\n")
  end

  def format_chars_to_translate(message)
    add_line_breaks(reformat_numbers(message.downcase))
  end

  def add_line_breaks(message)
    message.chars.each_slice(40).map { |slice| slice.join.concat("\n") }
  end

  def reformat_numbers(message)
    num_hash = (('1'..'9').to_a << '0').zip(('#a'..'#j').to_a).to_h
    num_hash.keys.each { |key| message.gsub!(key, num_hash[key])}
    message
  end

  def change_letters_to_numbers(message)
    letter_hash = ('#a'..'#j').to_a.zip(('1'..'9').to_a << '0').to_h
    letter_hash.keys.each { |key| message.gsub!(key, letter_hash[key])}
    message
  end
end