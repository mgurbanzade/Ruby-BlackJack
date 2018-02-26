module HelperMethods
  def result
    case winner
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

  def score(user)
    values = []
    user.current_cards.each do |card|
      values << 10 if card.symbol?(card.name)
      values << 11 if card.ace?(card.name)
      values << card.name if card.name.is_a? Integer
    end

    values[values.index(11)] = 1 if values.include?(11) && values.sum > 21
    values[values.index(1)] = 11 if values.include?(1) && values.sum + 10 <= 21
    values.sum
  end

  def play_again
    view.division_line
    view.play_again?
    again = gets.chomp.to_i
    start_round if again == 1
    view.bye if again == 2
  end

  def winner
    return player if score(dealer) > 21
    return dealer if score(player) > 21
    return player if score(player) > score(dealer) && score(player) <= 21
    return dealer if score(dealer) > score(player) && score(dealer) <= 21
    'draw' if score(dealer) == score(player)
  end

  def can_play_again?
    player.bank > 10 && dealer.bank > 10
  end

  def card_score_count(user, opponent)
    score(user) > 21 || opponent.current_cards.length > 2
  end

  def checkout(user, amount)
    user.bank -= amount
  end
end
