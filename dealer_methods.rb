module DealerMethods
  def dealer_actions
    return dealer_skips if dealer.score >= 17
    control_dealer_actions if dealer.current_cards.length < 3
  end

  def control_dealer_actions
    give_one_card(dealer)
    ask_show(:dealer_extra)
    return reveal if card_score_count(dealer, player)
    ask_show(:your_turn)
    show_player_actions
  end

  def dealer_skips
    ask_show(:dealer_skips)
    show_player_actions
  end
end
