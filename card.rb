class Card
  attr_accessor :suit, :name

  def initialize(suit, name)
    @suit = suit
    @name = name
  end

  def show
    "#{suit}#{name}"
  end
end
