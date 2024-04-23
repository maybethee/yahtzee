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

    @lower_section_methods = {
      1 => :three_of_a_kind,
      2 => :four_of_a_kind,
      3 => :full_house,
      4 => :small_straight,
      5 => :large_straight,
      6 => :yahtzee,
      7 => :chance
    }
  end

  def add_score(dice)
    # will use dice later
    puts dice

    display_categories

    puts "which category to apply score to? (can only score once per category)"

    # category choice will be the chosen category as code (a2, b5, etc.)
    category_code = category_decision

    apply_score_to_category(category_code, dice)
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

  def apply_score_to_category(category_code, dice)
    dice_arr_numbers = convert_dice_to_numbers(dice)

    if category_code[0] == 'a'
      # perform method that adds code to equivalent upper category code?
      apply_score_upper_category(category_code, dice_arr_numbers)
    else
      apply_score_lower_category(category_code, dice_arr_numbers)
    end
    display_categories
  end

  def convert_dice_to_numbers(dice_array)
    roll_as_numbers = []
    dice_array.each do |die|
      roll_as_numbers << DIE_FACE_TO_NUM_CONVERSION.fetch(die.current_roll.to_sym)
    end
    roll_as_numbers
  end

  def apply_score_upper_category(category_code, dice_array)
    upper_section_category = category_code[1].to_i
    # perform method that adds code to equivalent upper category code?
    score = dice_array.select { |die| die == upper_section_category }
    @upper_section[@upper_section.keys[(upper_section_category - 1)]] = score.sum
  end

  def apply_score_lower_category(category_code, dice_array)
    lower_section_category = category_code[1].to_i
    puts lower_section_category
    method = @lower_section_methods[lower_section_category]
    send(method, dice_array) if method
  end

  def three_of_a_kind(dice)
    # use group_by to create hash of dice array grouped by their numbers
    three_of_a_kind_score = dice.group_by { |die| die }.find { |k, v| v.size >= 3 }
    three_of_a_kind_score = three_of_a_kind_score ? three_of_a_kind_score.first * 3 : 0

    @lower_section[:three_of_a_kind] = three_of_a_kind_score
  end

  # same as three of a kind method, but this time... four
  def four_of_a_kind(dice)
    four_of_a_kind_score = dice.group_by { |die| die }.find { |k, v| v.size >= 4 }
    four_of_a_kind_score = four_of_a_kind_score ? four_of_a_kind_score.first * 4 : 0

    @lower_section[:four_of_a_kind] = four_of_a_kind_score
  end

  def yahtzee(dice)
    yahtzee = dice.group_by { |die| die }.find { |k, v| v.size >= 5 }

    # yahtzee gives 50 points no matter what die face (except for edge cases, to be added later)
    @lower_section[:yahtzee] = if yahtzee
                                 50
                               else
                                 0
                               end
  end

  def chance(dice)
    score = dice.sum
    @lower_section[:chance] = score
  end
end
