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

  describe 'message_array' do 
    it 'creates an array of character objects' do 
      expect(message.message_array.length).to eq(3)
      expect(message.message_array).to all(be_a Character)
      expect(message.message_array[0].character).to eq('a')
    end
  end
end