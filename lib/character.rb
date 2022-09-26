require './lib/modules/braille_library'

class Character
  attr_reader :character, :braille

  include BrailleLibrary

  def initialize(character)
    @character = character
  end

  def to_braille
    braille_library[character]
  end

  def to_character
    braille_library.key(character)
  end
end