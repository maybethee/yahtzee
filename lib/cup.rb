class Cup

  attr_accessor :dice, :previous_roll, :locked_dice

  def initialize
    @dice = Array.new(5) { Die.new }
  end

  def roll
    @dice.each do |die|
      die.current_roll = die.sides.sample unless die.locked?
    end
    show_current_roll
  end

  def change_chosen_dice_state(changed_dice)
    # subtract 1 from index_choice to match index
    changed_dice.each { |index_choice| @dice[index_choice - 1].change_state }
  end

  def all_locked?
    @dice.all? { |die| die.state == 'locked' }
  end

  def show_current_roll
    puts "current roll:"
    @dice.each_with_index do |die, index|
      puts "#{index + 1}. #{die.current_roll} | #{die.state}"
    end
    puts
  end
end
