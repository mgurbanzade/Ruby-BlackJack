require_relative 'card'

class Deck
  attr_reader :deck

  SUITS = ['♥', '♦', '♣', '♠'].freeze
  NAMES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A].freeze

  def initialize
    @deck = []
    generate_deck
  end

  private

  def generate_deck
    NAMES.each do |name|
      SUITS.each do |suit|
        @deck << Card.new(suit, name)
      end
    end
  end
end
