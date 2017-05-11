class CommandLineInterface
  include Speak

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
      player = User.new_user?
      get_name(player.name)
      @adventure = Adventure.start_new_adventure(player.id)
      @round = 1
      round_start
    when "2"
      snarky_response
      choose_adventure
    when "3"
      Adventure.show_high_scores
      STDIN.getch
      choose_adventure
    when "4"
      MealChoice.show_top_restaurants
      STDIN.getch
      choose_adventure
    when "5"
      exit
    else
      not_valid_input
      choose_adventure
    end
  end

  def round_start
    if @adventure.wallet_now > 0.0 #should be done in adventure class
      if @round <= 3
        # @adventure.display_wallet
        # options_for_meals(@round) # just added
        # @adventure.give_options
        # #@adventure.prompt_give_tip
        # @adventure.calculate_meal
        # @adventure.reset_choice_array
        # @round += 1
        # @adventure.random_event
        Adventure.begin_round(@adventure,@round)
        @round += 1
        round_start
      else
        finished_end_of_game_message
        @adventure.user.set_high_score?(@adventure.score_calculator)
      end
    else
      lost_end_game_message
      @adventure.score = 0
    end
    @adventure.save
    return_main_menu_message
    STDIN.getch
    greet
  end
end
