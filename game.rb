require_relative 'db'
require_relative 'controller.rb'
require_relative 'interface'

class Game
  attr_reader :controller, :view, :player, :dealer, :deck, :bet
  attr_accessor :winner

  def initialize
    @view = Interface.new
    @controller = Controller.new
    @player = User.new(controller.ask_player_name)
    @dealer = User.new
    start_game
  end

  def start_game
    @deck = Deck.new
    @bet = 10
    @winner = false

    loop do
      system('clear')
      controller.start_new_round(player, dealer, deck, bet)
      control_player
      response = play_again if controller.can_play_again?(player, dealer)
      return view.exit_options unless controller.proper_response?(response)
      return start_game if response == 1
      break if response == 2
    end
  end

  def control_player
    loop do
      view.start_messages(bet, player, player.score)
      view.show_player_actions
      player_action = controller.player_response
      player_actions(player_action)
      break if winner == true
    end
  end

  def player_actions(action)
    case action
    when 1
      clear
      view.dealers_turn
      dealer_actions
    when 2
      clear
      return view.card_limit unless player.can_take_card?
      extra_card if player.can_take_card?
      return reveal_cards if controller.can_reveal?(player, dealer)
      dealer_actions
    when 3
      clear
      return reveal_cards
    end
  end

  def dealer_actions
    return view.players_turn if dealer.score >= 17
    if dealer.score < 17
      view.dealer_extra if dealer.can_take_card?
      dealer.take_card(deck) if dealer.can_take_card?
      return reveal_cards if controller.can_reveal?(dealer, player)
      view.your_turn
    end
  end

  def extra_card
    player.take_card(deck)
    view.player_extra
    view.player_score(player.score)
  end

  def reveal_cards
    view.reveal(player, controller, dealer)
    round_results
    self.winner = true
  end

  def round_results
    case controller.winner(player, dealer)
    when player
      player_bank = player.bank += bet * 2
      view.player_won(player_bank)
    when dealer
      dealer.bank += bet * 2
      view.dealer_won
    when 'draw'
      player.bank += bet
      dealer.bank += bet
      view.draw
    end
  end

  def play_again
    view.division_line
    view.play_again?
    again = controller.player_response
  end

  private

  def clear
    system('clear')
  end
end

Game.new
