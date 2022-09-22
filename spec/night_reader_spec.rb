require 'rspec'
require './lib/night_reader'

RSpec.describe NightReader do 
  let(:night_reader) {NightReader.new({ braille_path: 'braille.txt', write_path: 'original_message.txt' })}

  describe '#initialize' do 
    it 'exists' do 
      expect(night_reader).to be_a NightReader
    end
    it 'has a braille file path' do 
      # allow(NightReader).to receive(:ARGV[0]).and_return('message.txt')
      expect(night_reader.braille_path).to eq('braille.txt')
    end
    it 'has a file path to write to' do 
      # allow(NightReader).to receive(:ARGV[0]).and_return('braille.txt')
      expect(night_reader.write_path).to eq('original_message.txt')
    end
    it 'starts with no message' do 
      expect(night_reader.message).to eq('')
    end
  end

  describe '#character_statement' do 
    it 'writes a message' do 
      night_reader.open_file
      expect(night_reader.character_statement).to eq("Created 'original_message.txt' containing 11 characters")
    end
  end

  describe '#open_file' do 
    it 'opens a file' do 
      expect(night_reader.open_file).to be_a File
    end
    it 'saves file contents to message variable' do 
      night_reader.open_file
      expect(night_reader.message).to eq(['0.0.0.0.0....00.0.0.00', '00.00.0..0..00.0000..0', '....0.0.0....00.0.0...'])
    end
  end
end