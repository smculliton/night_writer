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
      night_writer.open_file(night_writer.message_path)
      expect(night_writer.character_statement).to eq("Created 'braille.txt' contains 11 characters")
    end
  end

  describe '#open_file' do 
    it 'opens a file' do 
      expect(night_writer.open_file(night_writer.message_path)).to be_a File
    end
    it 'saves file contents to message variable' do 
      night_writer.open_file(night_writer.message_path)
      expect(night_writer.message).to eq('hello world')
    end
  end

  describe '#translate_braille' do 
    it 'translates a message to braille' do 
      expect(night_writer.translate_braille('a')).to eq("0.\n..\n..")
    end 
    it 'works with multiple letters and spaces' do 
      expect(night_writer.translate_braille('a bc')).to eq("0...0.00\n....0...\n........")
    end
  end

  describe '#braille_row' do 
    it 'returns a row of braille' do 
      expect(night_writer.braille_row('a', 0)).to eq('0.')
    end
    it 'works with multiple letters and a different row' do 
      expect(night_writer.braille_row('abc', 1)).to eq('..0...')
    end
    it 'translates spaces' do 
      expect(night_writer.braille_row(' ', 0)).to eq('..')
    end
  end

  describe '#write_file' do 
    before(:each) do 
      @content = night_writer.translate_braille('a')
    end
    it 'opens a file to write' do 
      expect(night_writer.write_file(night_writer.write_path, @content)).to be_a File
    end
    it 'writes content to the file' do 
      tested = File.open(night_writer.write_path).read
      expect(tested).to eq(@content)
    end
  end

  describe '#row_splitter' do 
    it 'splits rows that are too large and creates a new line' do 
      tested = ''
      41.times { tested.concat('.0')}

      expect(night_writer.row_splitter([tested])).to eq([tested[0..79], '', tested[80..81]])
    end
    it 'splits rows twice if they are 160+ characters' do 
      tested = ''
      81.times { tested.concat('.0')}

      expect(night_writer.row_splitter([tested])).to eq([tested[0..79], '', tested[80..159], '', tested[160..161]])
    end
    it 'works with multiple rows' do 
      tested1 = ''
      tested2 = ''
      tested = [tested1, tested2]

      41.times { tested1.concat('.0')}
      41.times { tested2.concat('0.')}

      expect(night_writer.row_splitter(tested)).to eq([tested1[0..79], tested2[0..79], '', tested1[80..81], tested2[80..81]])
    end
  end
end