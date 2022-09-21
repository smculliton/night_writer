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

  def open_file(filepath = message_path)
    file = File.open(filepath)
    @message = file.read.chomp.downcase
    file
  end

  def write_file(content, filepath = write_path)
    file = File.open(filepath, 'w')
    file.write(content)
    file.close_write
    file
  end

  def translate_braille(string = message)
    translation = []
    3.times { |i| translation << braille_row(string, i) }
    translation = row_splitter(translation)
    translation.join("\n")
  end

  def braille_row(string, row)
    string.chars.map { |letter| braille_library[letter][row] }.join
  end
  
  def row_splitter(translation)
    return translation if translation.none? { |row| row.length > 80 }
    translation << ''
    translation.select { |row| row.length > 80 }.each do |row|
      # edge case - somehow two rows of braille are exactly identical

      translation[translation.index(row)] = row[0..79]
      translation << row[80..row.length]
    end

    row_splitter(translation)
  end
end
