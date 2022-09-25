require './lib/night_writer'
require './lib/night_reader'

night_writer = NightWriter.new({ message_path: 'message.txt', write_path: 'braille.txt' })
night_writer.open_file
braille = night_writer.translate_braille
night_writer.write_file(braille)
puts night_writer.character_statement

night_reader = NightReader.new({ message_path: 'braille.txt', write_path: 'original_message.txt'})
night_reader.open_file
braille = night_reader.translate_to_english
night_reader.write_file(braille)
puts night_reader.character_statement
