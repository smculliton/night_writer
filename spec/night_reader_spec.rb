require 'rspec'
require './lib/night_reader'

RSpec.describe NightReader do 
  let(:night_reader) {NightReader.new({ message_path: 'braille.txt', write_path: 'original_message.txt' })}

  describe '#initialize' do 
    it 'exists' do 
      expect(night_reader).to be_a NightReader
    end
    it 'has a braille file path' do 
      expect(night_reader.message_path).to eq('braille.txt')
    end
    it 'has a file path to write to' do 
      expect(night_reader.write_path).to eq('original_message.txt')
    end
    it 'starts with no message' do 
      expect(night_reader.message).to eq('')
    end
  end

  describe '#character_statement' do 
    it 'writes a message' do 
      # night_reader.open_file
      braille = ['0.0.0.0.0....00.0.0.00', '00.00.0..0..00.0000..0', '....0.0.0....00.0.0...']
      allow(night_reader).to receive(:message).and_return(braille)
      expect(night_reader.character_statement).to eq("Created 'original_message.txt' containing 11 characters")
    end
  end

  describe '#open_file' do 
    it 'opens a file' do 
      expect(night_reader.open_file).to be_a File
    end
    it 'saves file contents to message variable' do 
      array = double('hello world')
      braille = ['0.0.0.0.0....00.0.0.00', '00.00.0..0..00.0000..0', '....0.0.0....00.0.0...']
      allow(File).to receive(:open).and_return(array)
      allow(array).to receive(:readlines).and_return(braille)

      night_reader.open_file
      expect(night_reader.message).to eq(['0.0.0.0.0....00.0.0.00', '00.00.0..0..00.0000..0', '....0.0.0....00.0.0...'])
    end
  end

  describe '#translate_to_english' do 
    it 'translates a letter from braille to english' do 
      night_reader.open_file
      expect(night_reader.translate_to_english(['0.', '00', '..'])).to eq('h')
    end
    it 'translates more than one letter' do 
      tested = ['0.0.0.0.0....00.0.0.00', '00.00.0..0..00.0000..0', '....0.0.0....00.0.0...']
      expect(night_reader.translate_to_english(tested)).to eq('hello world')
    end
    it 'translates messages that are greater than one line long' do 
      long_braille_message = [".00.0...000..0000...0.0.0..000..000.00...00.0000.0..0.0.0.0....00.0...0.0.0.00..",
        "0000.0..00..0.......0.00.000.0..0..0....00....0.0....00..000..0000.0..0....0.0..",
        "0.......0.00....0.....0.0..00.....0.00....000.0.0...0.00..0...0.......0...0000..",
        "",
        "000.00",
        ".0.000",
        "..0..."]
        expected = 'the quick brown fox jumps over the lazy dog'
        expect(night_reader.translate_to_english(long_braille_message)).to eq(expected)
    end
  end

  describe '#braille_letters' do 
    it 'reorganizes braille array into one braille letter based on an index' do 
      # tested equals braille for 'hello world'
      tested = ['0.0.0.0.0....00.0.0.00', '00.00.0..0..00.0000..0', '....0.0.0....00.0.0...']
      # asks for first letter of 'hello world'
      expect(night_reader.braille_letter(tested, 0)).to eq(['0.', '00', '..'])
      # asks for fifth letter of 'hello world'
      expect(night_reader.braille_letter(tested, 4)).to eq(['0.','.0','0.'])
    end
  end
  
  describe '#write_file' do 
    before(:each) do 
      @content = night_reader.translate_to_english(['0.', '..', '..'])
    end
    it 'opens a file to write' do 
      expect(night_reader.write_file(@content)).to be_a File
    end
    it 'writes content to the file' do 
      tested = File.open(night_reader.write_path).read
      expect(tested).to eq(@content)
    end
  end
end