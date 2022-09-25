require './lib/braille_writer'

class NightWriter

  def self.write(message_path, write_path)
    braille_writer = BrailleWriter.new({ message_path: message_path, write_path: write_path})
    braille_writer.open_file
    braille = braille_writer.translate_braille
    braille_writer.write_file(braille)
    puts braille_writer.character_statement
  end

end

NightWriter.write(ARGV[0], ARGV[1])
