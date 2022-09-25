class BrailleTranslator
  attr_reader :message_path, :write_path, :message

  def initialize(hash)
    @message_path = hash[:message_path]
    @write_path = hash[:write_path]
    @message = ''
  end

  def character_statement
    "Created '#{write_path}' containing #{message_length} characters"
  end

  def message_length
    message.length
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
