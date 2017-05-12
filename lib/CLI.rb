class CommandLineInterface
  include Speak

  def greet
    greet_and_rules
    choose_adventure
  end

  def choose_adventure
    main_menu
    input = gets.chomp
    case input.downcase
    when "1"
      player = User.new_user?
      get_name(player.name)
      Neighborhood.choose_neighborhood
      @adventure = Adventure.start_new_adventure(player.id)
      @round = 1
      round_start
    when "2"
      snarky_response
      choose_adventure
    when "3"
      Adventure.show_high_scores
      choose_adventure
    when "4"
      MealChoice.show_top_restaurants
      choose_adventure
    when "5", "exit", "quit"
      goodbye_message
      exit
    when "back"
      greet
    else
      not_valid_input
      choose_adventure
    end
  end

  def round_start
    if @adventure.wallet_now > 0.0
      if @round <= 3
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
