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
    dice_cup = Cup.new
    puts "choose which dice to lock/unlock"
    locked_dice = lock_decision

    dice_cup.change_chosen_dice_state(locked_dice)

    dice_cup.roll
  end

  def lock_decision
    loop do
      error_message = "Invalid input.\n\nformat input using only numbers with a single space between\nno commas or other punctuation!"
      dice_choice = gets.chomp.strip

      # turn string into array of numbers
      dice_choice_arr = dice_choice.split(' ').map(&:to_i)
      return dice_choice_arr if valid?(dice_choice_arr)

      puts error_message
    end
  end

  def valid?(dice_choice_arr)
    is_valid = dice_choice_arr.all? { |num| num.between?(1, 5) }

    is_unique = dice_choice_arr.uniq.length == dice_choice_arr.length

    is_valid && is_unique
  end

  def next_player
    @current_player = @players.rotate!.first
  end
end
