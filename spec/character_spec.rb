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
      expect(character.to_braille).to eq(['O.', '..', '..'])
    end
  end
  context 'new line characters' do 
    let(:character) { Character.new("\n") }
    it 'can handle a new line character' do 
      expect(character.to_braille).to eq(["\n", "\n", "\n"])
    end
  end

  describe '#to_character' do
    let(:character) { Character.new(['O.', '..', '..']) }

    it 'turns a braille into a character' do 
      expect(character.to_character).to eq('a')
    end
  end
end
