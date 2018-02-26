require_relative 'user'
require_relative 'card'
require_relative 'deck'

class Controller

  def score(user)
    values = []
    user.current_cards.each do |card|
      values << 10 if card.symbol?(card.name)
      values << 11 if card.ace?(card.name)
      values << card.name if card.name.is_a? Integer
    end

    values[values.index(11)] = 1 if values.include?(11) && values.sum > 21
    values[values.index(1)] = 11 if values.include?(1) && values.sum + 10 <= 21
    values.sum
  end

  def start_new_round(player, dealer, deck, bet)
    checkout(player, bet)
    checkout(dealer, bet)
    player.current_cards.clear
    dealer.current_cards.clear
    player.take_2_cards(deck)
    dealer.take_2_cards(deck)
  end

  def winner(player, dealer)
    return player if score(dealer) > 21
    return dealer if score(player) > 21
    return player if score(player) > score(dealer) && score(player) <= 21
    return dealer if score(dealer) > score(player) && score(dealer) <= 21
    'draw' if score(dealer) == score(player)
  end

  def can_play_again?(player, dealer)
    player.bank > 10 && dealer.bank > 10
  end

  def card_score_count(user, opponent)
    score(user) > 21 || opponent.current_cards.length > 2
  end

  def checkout(user, amount)
    user.bank -= amount
  end

  def ask_player_name
    gets.chomp
  end

  def player_response
    gets.chomp.to_i
  end
end
