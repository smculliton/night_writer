require 'rspec'
require './lib/character'

RSpec.describe Character do
  let(:character) { Character.new('a') }

  describe '#initialize' do 
    it 'exists' do 
      expect(character).to be_a Character
    end
    it 'has a character' do 
      expect(character.character).to eq('a')
    end
  end

  describe '#to_braille' do 
    it 'turns an english character into a braille hash' do 
      expect(character.to_braille).to eq({
                                           top: '0.',
                                           middle: '..',
                                           bottom: '..'
                                         })
    end
  end
end
