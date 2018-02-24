module ShowMethods
  def show_player_actions
    division_line
    ask_show(:action)
    ask_show(:skip)
    ask_show(:get_card)
    ask_show(:reveal)
    player_action = gets.chomp.to_i
    player_actions(player_action)
  end

  def play_again?
    ask_show(:play_again)
    ask_show(:yep)
    ask_show(:nah)
  end

  def start_messages
    ask_show(:bet, "$#{current_bet}")
    ask_show(:current_bank, "$#{player.bank}")
    ask_show(:your_cards, show_cards(player).join(' '))
    ask_show(:your_score, player.score)
    ask_show(:my_cards)
  end

  def division_line
    puts '-------------------'
  end

  def intro_messages
    ask_show(:greet)
    ask_show(:bank, "$#{player.bank}")
    ask_show(:start)
  end
end
