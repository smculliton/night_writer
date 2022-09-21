require './lib/night_writer'

night_writer = NightWriter.new({ message_path: 'message.txt', write_path: 'braille.txt' })
night_writer.open_file
braille = night_writer.translate_braille
night_writer.write_file(braille)
puts night_writer.character_statement