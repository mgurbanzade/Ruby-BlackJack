class Interface
  def initialize
    show_info(:name)
  end

  def start_messages(bet, player, score)
    division_line
    show_info(:bet, "$#{bet}")
    show_info(:current_bank, "$#{player.bank}")
    show_info(:your_cards, "#{player.show_cards}")
    show_info(:your_score, score)
    show_info(:my_cards)
  end

  def reveal(player, controller, dealer)
    division_line
    player_cards(player.show_cards)
    player_score(player.score)
    division_line
    dealer_cards(dealer.show_cards)
    dealer_score(dealer.score)
    division_line
  end

  def show_player_actions
    division_line
    show_info(:action)
    show_info(:skip)
    show_info(:get_card)
    show_info(:reveal)
  end

  def player_won(bank)
    show_info(:player_won)
    show_info(:current_bank, "$#{bank}")
  end

  def player_cards(player_cards)
    show_info(:your_cards, player_cards)
  end

  def player_extra
    show_info(:player_extra)
  end

  def player_score(score)
    show_info(:your_score, score)
  end

  def players_turn
    show_info(:dealer_skips)
  end

  def dealers_turn
    show_info(:player_skips)
  end

  def dealer_cards(dealer_cards)
    show_info(:dealer_cards, dealer_cards)
  end

  def dealer_score(score)
    show_info(:my_score, score)
  end

  def dealer_extra
    show_info(:dealer_extra)
  end

  def dealer_won
    show_info(:dealer_won)
  end

  def intro_messages
    show_info(:greet)
    show_info(:start)
    gets.chomp
  end

  def play_again?
    show_info(:play_again)
    show_info(:yep)
    show_info(:nah)
  end

  def draw
    show_info(:draw)
  end

  def your_turn
    show_info(:your_turn)
  end

  def card_limit
    show_info(:card_limit)
  end

  def exit_options
    show_info(:exit_options)
  end

  def division_line
    puts '-------------------'
  end

  private

  def show_info(val, arg = nil)
    puts ASK_SHOW[val] if arg.nil?
    puts "#{ASK_SHOW[val]} #{arg}" unless arg.nil?
  end
end
