class FileIO
  def self.open_file(filename)
    file = File.open(filename)
    file.read.chomp
  end

  def self.write_file(content, filename)
    file = File.open(filename, 'w')
    file.write(content)
  end
end
