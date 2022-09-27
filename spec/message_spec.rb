require 'rspec'
require './lib/message'

RSpec.describe Message do 
  let(:message) { Message.new(['abc', 'def']) }

  describe '#initialize' do
    it 'exists' do 
      expect(message).to be_a Message
    end
    it 'has a message' do 
      expect(message.message).to eq(['abc', 'def'])
    end
  end

  describe '#create_message_array' do 
    it 'creates arrays of characters by row' do 
      message.create_message_array

      expect(message.message_array.flatten).to all(be_a Character)
      expect(message.message_array[0][0].character).to eq('a')
      expect(message.message_array[1][0].character).to eq('d')
    end
  end
end