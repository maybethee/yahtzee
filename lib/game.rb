require_relative 'player'
require_relative 'die'
require_relative 'cup'
require_relative 'scorecard'

class Game
  def initialize
    @players = [Player.new('Player 1'), Player.new('Player 2')]
    @current_player = @players.first
  end

  def play
    player_turn
  end

  def player_turn
    # allows each player to roll and score 13 times
    (13 * @players.size).times do
      dice_cup = Cup.new
      roll_loop(dice_cup)
      @current_player.turn_score(dice_cup.dice)
      next_player
    end
    calculate_all_totals
    call_winner
  end

  def roll_loop(cup)
    cup.roll
    2.times do
      puts "\n#{@current_player.name}, choose which dice to lock/unlock. locking all dice will skip to scoring phase.\n"
      locked_dice = lock_decision

      cup.change_chosen_dice_state(locked_dice)

      # jump to scoring if player is set on dice before 2 loops
      break if cup.dice.all?(&:locked?)

      cup.roll
    end
  end

  def lock_decision
    loop do
      error_message = "\nInvalid input.\n\nformat input using only numbers with a single space between"
      dice_choice = gets.chomp.strip

      # turn string into array of numbers
      dice_choice_arr = dice_choice.split(' ').map(&:to_i)
      return dice_choice_arr if valid?(dice_choice_arr)

      puts error_message
    end
  end

  def calculate_all_totals
    @players.each do |player|
      puts "\n______________#{player.name}______________"

      player.scorecard.calculate_total
    end
  end

  def call_winner
    @players.sort_by { |player| -player.scorecard.total_score }

    # first player after sorted in descending order by total score is the winner (too lazy to allow for ties)
    puts "\n#{@players.first.name} wins!\n\nTotal Scores:"
    puts "\n_____________________________"
    puts '|  PLAYER      |   TOTAL    |'
    puts '|______________|____________|'
    @players.each do |player|
      puts "|  #{player.name}    |   #{player.scorecard.total_score}"
      puts '|______________|____________|'
    end
  end

  def valid?(dice_choice_arr)
    # need to include edge cases like player locking all dice on first decision / allowing player to break roll loop after first roll when favorable
    is_valid = dice_choice_arr.all? { |num| num.between?(1, 5) }

    is_unique = dice_choice_arr.uniq.length == dice_choice_arr.length

    is_valid && is_unique
  end

  def next_player
    @current_player = @players.rotate!.first
    # puts "#{@current_player.name}'s turn!"
  end
end
