require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'player_methods'
require_relative 'dealer_methods'
require_relative 'helper_methods'

class Controller
  include PlayerMethods
  include DealerMethods
  include HelperMethods

  attr_reader :player, :dealer, :deck, :bet

  def ask_player_name
    gets.chomp
  end

  def player_response
    gets.chomp
  end

  def start_new_round(player, dealer, deck, bet)
    checkout(player, bet)
    checkout(dealer, bet)
    player.current_cards.clear
    dealer.current_cards.clear
    player.take_2_cards(deck)
    dealer.take_2_cards(deck)
  end

  def reveal
    view.division_line
    view.player_cards(player.show_cards)
    view.player_score(score(player))
    view.division_line
    view.dealer_cards(dealer.show_cards)
    view.dealer_score(score(dealer))
    view.division_line
    result
    play_again if can_play_again?
    view.bye unless can_play_again?
  end
end
