class User
  attr_accessor :bank, :current_cards

  def initialize(name = 'Dealer')
    @bank = 100
    @current_cards = []
    @name = name
  end

  def score
    values = []
    current_cards.each do |card|
      values << 10 if card.symbol?(card.name)
      values << 11 if card.ace?(card.name)
      values << card.name if card.name.is_a? Integer
    end

    values[values.index(11)] = 1 if values.include?(11) && values.sum > 21
    values[values.index(1)] = 11 if values.include?(1) && values.sum + 10 <= 21
    values.sum
  end

  def take_card(deck)
    limit = deck.deck.length - 1
    random = rand(0..limit)
    card = deck.deck[random]
    current_cards << card
    deck.deck.delete(card)
  end

  def take_2_cards(deck)
    2.times do
      take_card(deck)
    end
  end

  def show_cards
    cards = []
    current_cards.each { |card| cards << "#{card.suit}#{card.name}" }
    cards.join(' ')
  end

  def can_take_card?
    current_cards.length < 3
  end
end
