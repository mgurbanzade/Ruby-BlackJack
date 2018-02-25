class Card
  attr_accessor :suit, :name

  def initialize(suit, name)
    @suit = suit
    @name = name
  end

  def symbol?(name)
    name == :J || name == :Q || name == :K
  end

  def ace?(name)
    name == :A
  end
end
