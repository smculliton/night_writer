require 'rspec'
require './lib/message'

RSpec.describe Message do 
  let(:message) { Message.new('abc') }

  describe '#initialize' do
    it 'exists' do 
      expect(message).to be_a Message
    end
    it 'has a message' do 
      expect(message.message).to eq('abc')
    end
  end

  describe '#create_message_array' do 
    it 'creates an array of character objects' do 
      message.create_message_array

      expect(message.message_array.length).to eq(3)
      expect(message.message_array).to all(be_a Character)
      expect(message.message_array[0].character).to eq('a')
    end
  end

  describe '#create_braille_array' do 
    let(:message) { Message.new([['0.','..','..'], ['0.','0.','..'], ['00','..','..']]) }
    it 'creates an array of character objects' do 
      message.create_message_array

      expect(message.message_array.length).to eq(3)
      expect(message.message_array).to all(be_a Character)
      expect(message.message_array[0].character).to eq(['0.','..','..'])
      expect(message.message_array[0].to_character).to eq('a')
    end
  end
end