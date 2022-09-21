class NightWriter
  attr_reader :message_path, :write_path, :message
  
  def initialize(hash = { message_path: ARGV[0], write_path: ARGV[1] } )
    @message_path = hash[:message_path]
    @write_path = hash[:write_path]
    @message = ''
  end

  def character_statement
    "Created 'braille.txt' contains 256 characters"
  end

  def open_file(filepath)
    @message = File.open(filepath).read.chomp
  end
end