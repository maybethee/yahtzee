class Cup
  DIE_FACE_TO_NUM_CONVERSION = { '⚀': 1, '⚁': 2, '⚂': 3, '⚃': 4, '⚄': 5, '⚅': 6 }.freeze

  attr_accessor :dice, :previous_roll, :locked_dice

  def initialize
    # @dice array only references inital number of dice and possible faces
    # everything related to a player's rolled dice will use @previous_roll
    # @dice will only get updated with how many dice live in the array

    @dice = Array.new(6) { Die.new }
    @previous_roll = []
    @locked_dice = []
  end

  def roll
    # previous_roll gets overwritten here
    @dice.each do |die|
      @previous_roll << die.sides.sample
    end
    puts @previous_roll
  end
end
