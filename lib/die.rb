class Die
  attr_reader :sides
  attr_accessor :current_roll, :state

  def initialize
    @sides = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅']
    @current_roll = ''
    @state = 'unlocked'
  end

  def change_state
    @state = @state == 'unlocked' ? 'locked' : 'unlocked'
  end

  def locked?
    @state == 'locked'
  end
end
