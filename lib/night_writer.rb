require './lib/braille_library'

class NightWriter
  attr_reader :message_path, :write_path, :message

  include BrailleLibrary

  def initialize(hash = { message_path: ARGV[0], write_path: ARGV[1] } )
    @message_path = hash[:message_path]
    @write_path = hash[:write_path]
    @message = ''
  end

  def character_statement
    "Created '#{write_path}' contains #{message.length} characters"
  end

  def open_file(filepath)
    @message = File.open(filepath).read.chomp
  end

  def write_file(filepath, content)
    file = File.open(filepath, 'w')
    file.write(content)
    file.close_write
    file
  end

  def translate_braille(string)
    translation = ''
    3.times { |i| translation.concat("#{braille_row(string, i)}\n") }
    translation.chomp
  end

  def braille_row(string, row)
    string.chars.map { |letter| braille_library[letter][row] }.join
  end
end