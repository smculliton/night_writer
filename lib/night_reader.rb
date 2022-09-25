require './lib/braille_reader'

class NightReader
  def self.read(message_path, write_path)
    braille_reader = BrailleReader.new({ message_path: message_path, write_path: write_path})
    braille_reader.open_file
    braille = braille_reader.translate_to_english
    braille_reader.write_file(braille)
    puts braille_reader.character_statement
  end
end

NightReader.read(ARGV[0], ARGV[1])