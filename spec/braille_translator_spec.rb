require 'rspec'
require './lib/braille_translator'

RSpec.describe BrailleTranslator do 
  let(:braille_translator) { BrailleTranslator.new({ message_path: 'message.txt', write_path: 'braille.txt' }) }

  describe '#initialize' do
    it 'exists' do 
      expect(braille_translator).to be_a BrailleTranslator 
    end
    it 'has a message file path' do 
      expect(braille_translator.message_path).to eq('message.txt')
    end
    it 'has a file path to write to' do 
      expect(braille_translator.write_path).to eq('braille.txt')
    end
    it 'starts with no message' do 
      expect(braille_translator.message).to eq('')
    end
  end

  describe '#character_statement' do 
    it 'writes a message' do 
      allow(braille_translator).to receive(:message_length).and_return(11)

      expect(braille_translator.character_statement).to eq("Created 'braille.txt' containing 11 characters")
    end
  end

  describe '#open_file' do 
    it 'opens a file' do 
      expect(braille_translator.open_file(braille_translator.message_path)).to be_a File
    end
    it 'saves file contents to message variable' do 
      string = double('hello world')
      allow(File).to receive(:open).and_return(string)
      allow(string).to receive(:read).and_return('hello world')

      braille_translator.open_file(braille_translator.message_path)
      expect(braille_translator.message).to eq('hello world')
    end
  end

  describe '#write_file' do 
    before(:each) do 
      @content = 'hello world'
    end
    it 'opens a file to write' do 
      expect(braille_translator.write_file(@content)).to be_a File
    end
    it 'writes content to the file' do 
      tested = File.open(braille_translator.write_path).read
      expect(tested).to eq(@content)
    end
  end
end
