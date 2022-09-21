require 'rspec'
require './lib/night_writer'

RSpec.describe NightWriter do
  let(:night_writer) { NightWriter.new({ message_path: 'message.txt', write_path: 'braille.txt' }) }

  describe '#initialize' do
    it 'exists' do 
      expect(night_writer).to be_a NightWriter 
    end
    it 'has a message file path' do 
      # allow(NightWriter).to receive(:ARGV[0]).and_return('message.txt')
      expect(night_writer.message_path).to eq('message.txt')
    end
    it 'has a file path to write to' do 
      # allow(NightWriter).to receive(:ARGV[0]).and_return('braille.txt')
      expect(night_writer.write_path).to eq('braille.txt')
    end
    it 'starts with no message' do 
      expect(night_writer.message).to eq('')
    end
  end

  describe '#character_statement' do 
    it 'writes a message' do 
      expect(night_writer.character_statement).to eq("Created 'braille.txt' contains 256 characters")
    end
  end

  describe '#open_file' do 
    # it 'opens a file' do 
    #   expect(night_writer.open_file(night_writer.message_path)).to be_a File
    # end
    it 'saves file contents to message variable' do 
      night_writer.open_file(night_writer.message_path)
      expect(night_writer.message).to eq('hello world')
    end
  end

end