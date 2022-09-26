require './lib/message'

class BrailleTranslator
  attr_reader :message, :message_length

  def initialize(message)
    @message = message.split("\n")
    @message_length = 0
  end

  def translate_braille_to_english

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

    new_message = Message.new(translation.transpose)
    new_message.create_message_array
    @message_length = new_message.message_length
    new_message.message_array.map(&:to_character).join
  end
end
