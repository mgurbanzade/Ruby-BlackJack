module DealerShowMethods
  def dealers_turn
    ask_show(:player_skips)
  end

  def dealer_cards(dealer_cards)
    ask_show(:dealer_cards, dealer_cards)
  end

  def dealer_score(score)
    ask_show(:my_score, score)
  end

  def dealer_extra
    ask_show(:dealer_extra)
  end

  def dealer_won
    ask_show(:dealer_won)
  end
end
