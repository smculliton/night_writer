require 'rspec'
require './lib/braille_message'

RSpec.describe BrailleMessage do 
  message_in_braille = [['O.', '..', '..'], ['O.','O.','..'], ['O','..','..']]

  let(:braille_message) { BrailleMessage.new(message_in_braille)}

  describe '#create_message_array' do 
    it 'returns an array of character objects' do 
      expect(braille_message.create_message_array).to all(be_a Character)
      expect(braille_message.create_message_array[0].character).to eq(['O.', '..', '..'])
    end
  end

  describe '#message_length' do 
    it 'returns length of message array' do 
      expect(braille_message.message_length).to eq(3)
    end
  end
end