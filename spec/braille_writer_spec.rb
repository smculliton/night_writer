require 'rspec'
require './lib/braille_writer'

RSpec.describe BrailleWriter do
  let(:braille_writer) { BrailleWriter.new({ message_path: 'message.txt', write_path: 'braille.txt' }) }

  describe '#initialize' do
    it 'exists' do 
      expect(braille_writer).to be_a BrailleWriter 
    end
    it 'has a message file path' do 
      expect(braille_writer.message_path).to eq('message.txt')
    end
    it 'has a file path to write to' do 
      expect(braille_writer.write_path).to eq('braille.txt')
    end
    it 'starts with no message' do 
      expect(braille_writer.message).to eq('')
    end
  end

  describe '#character_statement' do 
    it 'writes a message' do 
      allow(braille_writer).to receive(:message).and_return('hello world')
      expect(braille_writer.character_statement).to eq("Created 'braille.txt' containing 11 characters")
    end
  end

  describe '#open_file' do 
    it 'opens a file' do 
      expect(braille_writer.open_file(braille_writer.message_path)).to be_a File
    end
    it 'saves file contents to message variable' do 
      string = double('hello world')
      allow(File).to receive(:open).and_return(string)
      allow(string).to receive(:read).and_return('hello world')

      braille_writer.open_file(braille_writer.message_path)
      expect(braille_writer.message).to eq('hello world')
    end
  end

  describe '#translate_braille' do 
    it 'translates a message to braille' do 
      expect(braille_writer.translate_braille('a')).to eq("0.\n..\n..")
    end 
    it 'works with multiple letters and spaces' do 
      expect(braille_writer.translate_braille('a bc')).to eq("0...0.00\n....0...\n........")
    end
  end

  describe '#braille_row' do 
    it 'returns a row of braille' do 
      expect(braille_writer.braille_row('a', 0)).to eq('0.')
    end
    it 'works with multiple letters and a different row' do 
      expect(braille_writer.braille_row('abc', 1)).to eq('..0...')
    end
    it 'translates spaces' do 
      expect(braille_writer.braille_row(' ', 0)).to eq('..')
    end
  end

  describe '#write_file' do 
    before(:each) do 
      @content = braille_writer.translate_braille('a')
    end
    it 'opens a file to write' do 
      expect(braille_writer.write_file(@content)).to be_a File
    end
    #need to fix this test
    it 'writes content to the file' do 
      tested = File.open(braille_writer.write_path).read
      expect(tested).to eq(@content)
    end
  end

  describe '#row_splitter' do 
    it 'splits rows that are too large and creates a new line' do 
      tested = ''
      41.times { tested.concat('.0')}

      expect(braille_writer.row_splitter([tested])).to eq([tested[0..79], tested[80..81]])
    end
    it 'splits rows twice if they are 160+ characters' do 
      tested = ''
      81.times { tested.concat('.0')}

      expect(braille_writer.row_splitter([tested])).to eq([tested[0..79], tested[80..159], tested[160..161]])
    end
    it 'works with multiple rows' do 
      tested1 = ''
      tested2 = ''
      tested = [tested1, tested2]

      41.times { tested1.concat('.0')}
      41.times { tested2.concat('0.')}

      expect(braille_writer.row_splitter(tested)).to eq([tested1[0..79], tested2[0..79], tested1[80..81], tested2[80..81]])
    end
  end

  describe '#insert_line_breaks' do 
    it 'inserts an empty string every third row' do 
      tested = ['1','2','3','1','2','3','1','2','3']
      expected = ['1','2','3','', '1','2','3','','1','2','3']
      expect(braille_writer.insert_line_breaks(['1','2','3','4'])).to eq(['1','2','3', '', '4'])
      expect(braille_writer.insert_line_breaks(tested)).to eq(expected)
    end
  end
end