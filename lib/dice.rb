# should this be called dice roll?

class Dice
  attr_accessor :dice

  def initialize(dice_amount)
    @dice = Array.new(dice_amount) { Die.new }
  end

  def roll
    @dice.each { |die| puts die.sides.sample }
  end
end