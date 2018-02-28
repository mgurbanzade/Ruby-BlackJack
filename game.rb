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
    @deck = Deck.new
    @bet = 10
    @winner = false
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
      return start_game if response == 1
      break if response == 2
    end
  end

  def control_player
    loop do
      view.start_messages(bet, player, controller.score(player))
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
      return view.card_limit unless controller.can_take_card?(player)
      extra_card if controller.can_take_card?(player)
      return reveal_cards if round_over_for?(player, dealer)
      dealer_actions
    when 3
      clear
      return reveal_cards
    end
  end

  def dealer_actions
    return view.players_turn if controller.score(dealer) >= 17
    if controller.score(dealer) < 17
      view.dealer_extra if controller.can_take_card?(dealer)
      dealer.take_card(deck) if controller.can_take_card?(dealer)
      return reveal_cards if round_over_for?(dealer, player)
      view.your_turn
    end
  end

  def extra_card
    player.take_card(deck)
    view.player_extra
    view.player_score(controller.score(player))
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

  def round_over_for?(user, opponent)
    controller.card_score_count(user, opponent)
  end
end

Game.new
