require_relative 'player'
require_relative 'die'
require_relative 'dice'

class Game
  def initialize
    # @players = [Player.new('Player 1'), Player.new('Player 2')]
  end

  def play
    puts "game start"
    roll_dice(6)
  end

  def roll_dice(dice_amount)
    dice = Dice.new(dice_amount)
    dice.roll
  end
end