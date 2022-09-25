class BrailleTranslator
  def initialize(hash = { message_path: ARGV[0], write_path: ARGV[1] } )
    @message_path = hash[:message_path]
    @write_path = hash[:write_path]
    @message = ''
  end

  def character_statement
    "Created '#{write_path}' containing #{message.length} characters"
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
end
