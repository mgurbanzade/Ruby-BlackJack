module PlayerMethods
  def player_actions
    player_action = gets.chomp.to_i
    control_player_actions(player_action)
  end

  def control_player_actions(action)
    return player_skips if action == 1
    return reveal if action == 3
    if action == 2
      give_one_card(player)
      view.player_extra
      view.player_score(score(player))
      return reveal if card_score_count(player, dealer)
      dealer_actions
    end
  end

  def player_skips
    view.dealers_turn
    dealer_actions
  end
end
