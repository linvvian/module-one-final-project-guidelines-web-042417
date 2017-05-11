class CommandLineInterface
  include Speak

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
      goodbye_message
      exit
    else
      not_valid_input
      choose_adventure
    end
  end

  def choose_neighborhood
    puts "Choose your neighborhood:"
    puts "1. Financial District"
    puts "2. East Village"
    puts ""
    puts "Enter 1 for Financial District or 2 for East Village"
    input = gets.chomp
    case input
    when "1"
      puts "Really? Alright, let's go."
      round_start
      # Adapter.
    when "2"
      puts "Good call. Let's get started."
      round_start
      # Adapter.
    else
      puts "Who taught you how to choose? Pick again."
      choose_neighborhood
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
