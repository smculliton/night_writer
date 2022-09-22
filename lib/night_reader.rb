class NightReader
  attr_reader :braille_path, :write_path, :message 

  def initialize(hash = { braille_path: ARGV[0], write_path: ARGV[1] } )
    @braille_path = hash[:braille_path]
    @write_path = hash[:write_path]
    @message = ''
  end

  def character_statement
    "Created 'original_message.txt' containing 11 characters."
  end

  def open_file(filepath = braille_path)
    file = File.open(filepath)
    @message = file.readlines.map(&:chomp)
    file
  end

end
