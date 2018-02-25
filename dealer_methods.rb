module DealerMethods
  def dealer_actions
    return dealer_skips if score(dealer) >= 17
    control_dealer_actions if dealer.current_cards.length < 3
  end

  def control_dealer_actions
    give_one_card(dealer)
    view.dealer_extra
    return reveal if card_score_count(dealer, player)
    view.your_turn
    player_actions
  end

  def dealer_skips
    view.players_turn
    player_actions
  end
end
