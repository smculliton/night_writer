require './lib/braille_translator'
require './lib/file_io'

class NightReader
  def self.write(read_filename, write_filename)
    message = FileIO.open_file(read_filename)
    translator = BrailleTranslator.new(message)
    FileIO.write_file(translator.translate_braille_to_english, write_filename)
    puts character_statement(write_filename, translator.message_length)
  end

  def self.character_statement(filename, message_length)
    "Created '#{filename}' containing #{message_length} characters"
  end
end

NightReader.write(ARGV[0], ARGV[1])