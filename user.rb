class User
  attr_accessor :bank, :current_cards

  def initialize(name = 'dealer')
    @bank = 100
    @current_cards = []
    @name = name
  end

  def score
    values = check_value

    values.each do |value|
      values[values.index(value)] = 10 if symbol?(value)
      values[values.index(value)] = 1 if ace?(value)
    end

    values[values.index(1)] = 11 if values.include?(1) && values.sum <= 21

    values.sum
  end

  protected

  def check_value
    values = []
    current_cards.each { |card| values << card.name }
    values
  end

  def symbol?(name)
    name == :J || name == :Q || name == :K
  end

  def ace?(name)
    name == :A
  end
end
