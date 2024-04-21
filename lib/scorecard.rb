class Scorecard
  DIE_FACE_TO_NUM_CONVERSION = { '⚀': 1, '⚁': 2, '⚂': 3, '⚃': 4, '⚄': 5, '⚅': 6 }.freeze

  attr_accessor :upper_section, :lower_section

  def initialize
    @upper_section = {
      ones: nil,
      twos: nil,
      threes: nil,
      fours: nil,
      fives: nil,
      sixes: nil
    }
    @lower_section = {
      three_of_a_kind: nil,
      four_of_a_kind: nil,
      full_house: nil,
      small_straight: nil,
      large_straight: nil,
      yahtzee: nil,
      chance: nil
    }
  end

  def add_score(dice)
    # will use dice later
    puts dice

    display_categories

    puts "which category to apply score to? (can only score once per category)"

    # category choice will be the chosen category as code (a2, b5, etc.)
    category_choice = category_decision

    # apply_score_to_category(category_code, dice)
  end

  def category_decision
    loop do
      # accepts category in the form of a1, b5, etc.
      error_message = "Invalid input.\n\nPlease choose one of the categories on the scorecard using [letter][number] formatting!"
      choice = gets.chomp.strip.downcase
      return choice if valid?(choice)

      puts error_message
    end
  end

  def display_categories
    puts 'A. Upper Section:'
    @upper_section.each_with_index do |(upper_category, score), index|
      puts "  #{index + 1}. #{upper_category}: #{score}"
    end
    puts 'B. Lower Section:'
    @lower_section.each_with_index do |(lower_category, score), index|
      puts "  #{index + 1}. #{lower_category}: #{score}"
    end
  end

  def valid?(choice)
    # first checks if input is a valid category
    return false unless %w[a1 a2 a3 a4 a5 a6 b1 b2 b3 b4 b5 b6 b7].include?(choice)

    # then evaluate if category score.nil? else invalid!
    # check upper section if choice letter was a
    if choice[0] == 'a'
      # find key via index (- 1) and check if it's nil (available)
      @upper_section[@upper_section.keys[(choice[1].to_i - 1)]].nil?
    # else check lower section
    else
      @lower_section[@lower_section.keys[(choice[1].to_i - 1)]].nil?
    end
  end
end