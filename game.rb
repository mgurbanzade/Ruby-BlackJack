require_relative 'db'
require_relative 'dealer'
require_relative 'user'
require_relative 'card'
require_relative 'deck'
require_relative 'show_methods'
require_relative 'player_methods'
require_relative 'dealer_methods'
require_relative 'helper_methods'

class Game
  include ShowMethods
  include PlayerMethods
  include DealerMethods
  include HelperMethods

  attr_reader :player, :dealer, :match_deck, :current_bet

  def initialize
    ask_show(:name)
    player_name = gets.chomp
    @dealer = Dealer.new
    @player = User.new(player_name)
    intro_messages
    gets.chomp
    start
  end

  def start
    @match_deck = Deck.new
    @current_bet = 10
    checkout(player, current_bet)
    checkout(dealer, current_bet)
    player.current_cards.clear
    dealer.current_cards.clear
    give_two_cards(player)
    give_two_cards(dealer)
    start_messages
    show_player_actions
  end

  def reveal
    division_line
    ask_show(:your_cards, show_cards(player).join(' '))
    ask_show(:your_score, player.score)
    division_line
    ask_show(:dealer_reveal, show_cards(dealer).join(' '))
    ask_show(:my_score, dealer.score)
    division_line
    result
    play_again if player.bank > 10 || dealer.bank > 10
  end

  def play_again
    division_line
    ask_show(:play_again)
    ask_show(:yep)
    ask_show(:nah)
    again = gets.chomp.to_i
    start if again == 1
    ask_show(:bye) if again == 2
  end

  def result
    case winner
    when player
      ask_show(:player_won, "Your bank is: $#{player.bank += current_bet * 2}")
    when dealer
      ask_show(:dealer_won, "Your bank is: $#{player.bank}")
    when 'draw'
      player.bank += current_bet
      dealer.bank += current_bet
      ask_show(:draw, "You saved your bank: $#{player.bank}")
    end
  end
end

Game.new
