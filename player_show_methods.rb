module PlayerShowMethods
  def show_player_actions
    division_line
    ask_show(:action)
    ask_show(:skip)
    ask_show(:get_card)
    ask_show(:reveal)
  end

  def player_won(bank)
    ask_show(:player_won)
    ask_show(:current_bank, "$#{bank}")
  end

  def player_cards(player_cards)
    ask_show(:your_cards, player_cards)
  end

  def player_extra
    ask_show(:player_extra)
  end

  def player_score(score)
    ask_show(:your_score, score)
  end

  def players_turn
    ask_show(:dealer_skips)
  end
end
