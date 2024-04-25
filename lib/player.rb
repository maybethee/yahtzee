class Player
  attr_reader :name
  attr_accessor :scorecard

  def initialize(name)
    @name = name
    @scorecard = Scorecard.new
  end

  def turn_score(dice)
    @scorecard.add_score(dice)
  end
end
