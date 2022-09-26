require 'rspec'
require './lib/file_io'

RSpec.describe FileIO do 
  describe '#self.open_file' do 
    it 'opens a file and reads contents' do 
      file = double('file')
      allow(File).to receive(:open).and_return(file)
      allow(file).to receive(:read).and_return("The quick brown fox\n")

      expect(FileIO.open_file('fake_file.txt')).to eq('the quick brown fox')
    end
  end

  describe '#self.write_file' do 
    it 'writes a file' do 
      file = double('file')
      content = double('content')
      allow(File).to receive(:open).and_return(file)
      allow(file).to receive(:write).and_return(content)

      expect(FileIO.write_file('content', 'fake_file.txt')).to eq(content)
    end
  end
end