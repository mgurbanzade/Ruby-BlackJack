require_relative 'user'
require_relative 'card'
require_relative 'deck'

class Controller
  def start_new_round(player, dealer, deck, bet)
    checkout(player, bet)
    checkout(dealer, bet)
    player.current_cards.clear
    dealer.current_cards.clear
    player.take_2_cards(deck)
    dealer.take_2_cards(deck)
  end

  def winner(player, dealer)
    return player if dealer.score > 21
    return dealer if player.score > 21
    return player if player.score > dealer.score && player.score <= 21
    return dealer if dealer.score > player.score && dealer.score <= 21
    'draw' if dealer.score == player.score
  end

  def can_play_again?(player, dealer)
    player.bank > 10 && dealer.bank > 10
  end

  def can_reveal?(user, opponent)
    user.score > 21 || opponent.current_cards.length > 2
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

  def proper_response?(response)
    response == 1 || response == 2
  end
end
