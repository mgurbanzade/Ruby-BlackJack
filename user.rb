class User
  attr_accessor :bank, :current_cards

  def initialize(name = 'dealer')
    @bank = 100
    @current_cards = []
    @name = name
  end

  def show_cards
    cards = []
    current_cards.each { |card| cards << "#{card.suit}#{card.name}" }
    cards.join(' ')
  end
end
