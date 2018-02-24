module HelperMethods
  private

  def give_two_cards(whom)
    2.times do
      give_one_card(whom)
    end
  end

  def give_one_card(whom)
    card = randomcard
    whom.current_cards << card
    match_deck.deck.delete(card)
    card
  end

  def winner
    return player if dealer.score > 21
    return dealer if player.score > 21
    return player if player.score > dealer.score && player.score <= 21
    return dealer if dealer.score > player.score && dealer.score <= 21
    'draw' if dealer.score == player.score
  end

  def card_score_count(user, opponent)
    user.score > 21 || opponent.current_cards.length > 2
  end

  def show_cards(user)
    cards = []
    user.current_cards.each { |card| cards << card.show }
    cards
  end

  def randomcard
    limit = match_deck.deck.length - 1
    random = rand(0..limit)
    match_deck.deck[random]
  end

  def ask_show(val, arg = nil)
    puts ASK_SHOW[val] if arg.nil?
    puts "#{ASK_SHOW[val]} #{arg}" unless arg.nil?
  end

  def checkout(user, amount)
    user.bank -= amount
  end

  def cash_in(user, amount)
    user.bank += amount
  end
end
