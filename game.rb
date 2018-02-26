require_relative 'db'
require_relative 'controller.rb'
require_relative 'interface'

class Game
  include PlayerMethods
  include DealerMethods
  include HelperMethods

  attr_reader :controller, :view, :player, :dealer, :deck, :bet

  def initialize
    @view = Interface.new
    @controller = Controller.new
    @player = Player.new(controller.ask_player_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bet = 10
    start_game
  end

  def start_game
    loop do
      controller.start_new_round(player, dealer, deck, bet)
      view.intro_messages
      view.start_messages(bet, player, controller.score(player))
      view.show_player_actions
      player_action = controller.player_response
      controller.control_player_actions(player_action)
    end
  end
end

Game.new
