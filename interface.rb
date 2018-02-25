require_relative 'player_show_methods'
require_relative 'dealer_show_methods'

class Interface
  include PlayerShowMethods
  include DealerShowMethods

  def initialize
    ask_show(:name)
  end

  def start_messages(bet, bank, cards, score)
    division_line
    ask_show(:bet, "$#{bet}")
    ask_show(:current_bank, "$#{bank}")
    ask_show(:your_cards, cards)
    ask_show(:your_score, score)
    ask_show(:my_cards)
  end

  def intro_messages
    ask_show(:greet)
    ask_show(:start)
    gets.chomp
  end

  def play_again?
    ask_show(:play_again)
    ask_show(:yep)
    ask_show(:nah)
  end

  def draw
    ask_show(:draw)
  end

  def your_turn
    ask_show(:your_turn)
  end

  def bye
    ask_show(:bye)
  end

  def division_line
    puts '-------------------'
  end

  private

  def ask_show(val, arg = nil)
    puts ASK_SHOW[val] if arg.nil?
    puts "#{ASK_SHOW[val]} #{arg}" unless arg.nil?
  end
end
