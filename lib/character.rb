require './lib/modules/braille_library'

class Character
  attr_reader :character, :braille

  include BrailleLibrary

  def initialize(character)
    @character = character
  end

  def to_braille
    braille = braille_library[character]
    # { top: braille[0], middle: braille[1], bottom: braille[2] }
  end
end