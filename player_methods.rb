module PlayerMethods
  def player_actions(action)
    return player_skips if action == 1
    return reveal if action == 3
    if action == 2
      ask_show(:player_extra, give_one_card(player).show)
      ask_show(:your_score, player.score)
      return reveal if card_score_count(player, dealer)
      dealer_actions
    end
  end

  def player_skips
    ask_show(:player_skips)
    dealer_actions
  end
end
