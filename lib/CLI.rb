class CommandLineInterface
  include Speak 
  
  def initialize
    @adventure = Adventure.new()
    @round = 1
  end

  #greet the user
  def greet
    greet_and_rules
    choose_adventure
  end

  def choose_adventure
    main_menu
    input = gets.chomp
    case input
    when "1"
      get_and_display_user_name
      User.new_user?
      round_start
    when "3"
      exit
    else
      not_valid_input
      choose_adventure
    end
  end

  def round_start
    if @adventure.wallet > 0.0 #should be done in adventure class
      if @round <= 3
        @adventure.display_wallet
        @adventure.give_options
        @adventure.prompt_give_tip
        prompt_user_for_choice
        @adventure.calculate_meal
        @adventure.reset_choice_array
        @round += 1
        @adventure.random_event
        round_start
      else
        finished_end_of_game_message
      end

    else
      lost_end_game_message
    end
  end
end
