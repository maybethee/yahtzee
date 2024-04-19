class Die
  attr_reader :sides

  def initialize
    @sides = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅']
  end

  # def roll
  #   puts @sides.sample
  # end
end