require_relative 'player'
require_relative 'die'
require_relative 'cup'

class Game
  def initialize
    @players = [Player.new('Player 1'), Player.new('Player 2')]
    @current_player = @players.first
  end

  def play
    player_turn
  end

  def player_turn
    dice_roll = Cup.new
    dice_roll.roll
  end

  def next_player
    @current_player = @players.rotate!.first
  end
end
