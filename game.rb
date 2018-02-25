require_relative 'db'
require_relative 'interface'
require_relative 'player'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'player_methods'
require_relative 'dealer_methods'
require_relative 'helper_methods'

class Game
  include PlayerMethods
  include DealerMethods
  include HelperMethods

  attr_reader :player, :dealer, :deck, :bet, :view

  def initialize
    @view = Interface.new
    player_name = gets.chomp
    @dealer = Dealer.new
    @player = User.new(player_name)
    start_round
  end

  def start_round
    @deck = Deck.new
    @bet = 10
    start_new_round
    view.intro_messages
    view.start_messages(bet, player.bank, player.show_cards, score(player))
    player_actions
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

Game.new
