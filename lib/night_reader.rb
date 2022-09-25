require './lib/braille_library'

class NightReader
  attr_reader :braille_path, :write_path, :message 

  include BrailleLibrary

  def initialize(hash = { braille_path: ARGV[0], write_path: ARGV[1] } )
    @braille_path = hash[:braille_path]
    @write_path = hash[:write_path]
    @message = ''
  end

  def character_statement
    "Created '#{write_path}' containing #{braille_length} characters"
  end

  def braille_length
    translate_to_english.length
  end

  def open_file(filepath = braille_path)
    file = File.open(filepath)
    # require 'pry'; binding.pry
    @message = file.readlines.map(&:chomp)
    file
  end

  def write_file(content, filepath = write_path)
    file = File.open(filepath, 'w')
    file.write(content)
    file.close_write
    file
  end

  def translate_to_english(braille_array = message)
    original_message = ''
    braille_array = combine_lines_of_braille(braille_array) if braille_array.length > 3
    (braille_array[0].length / 2).times do |index|
      original_message.concat(braille_library.key(braille_letter(braille_array, index)))
    end
    original_message
  end

  def braille_letter(braille_array, index)
    braille_array.map do |row|
      row[index*2..index*2+1]
    end
  end

  def combine_lines_of_braille(braille_array)
    braille_array.delete('')
    top = ''
    middle = ''
    bottom = ''
    braille_array.each_with_index do |line, index|
      top.concat(line) if index % 3 == 0
      middle.concat(line) if index % 3 == 1
      bottom.concat(line) if index % 3 == 2
    end
    [ top, middle, bottom ]
  end
end

# night_reader = NightReader.new
# night_reader.open_file
# require 'pry'; binding.pry