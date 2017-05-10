class CommandLineInterface

  def initialize
    @round = 1
  end

  #greet the user
  def greet
    puts "Welcome to the (title here) game!"
    choose_adventure
  end

  def choose_adventure
    puts "1. Start your adventure"
    puts "2. I do nothing"
    puts "3. Exit"
    puts "Pick a number: "
    input = gets.chomp
    case input
    when "1"
      player = User.new_user?
      @adventure = Adventure.start_new_adventure(player.id)
      round_start
    when "3"
      exit
    else
      puts "Choose RIGHT choice, READ"
      choose_adventure
    end
  end

  #prompts user for choice and gets user input
  def prompt_user_for_choice
    puts "Please select the restaurant you would like to eat at: 1, 2, or 3"
  end

  #
  #def show_restaurant_details(restaurant)
  #puts "#{restaurant.name} - Category: #{restaurant.category} Rating: #{restaurant.rating}"
  #end

  #kicks off the second and third rounds with an updated wallet total

  def round_start
    if @adventure.wallet_now > 0.0 #should be done in adventure class
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
        end_of_game_message
      end

    else
      puts "Game over, you're broke! Welcome to New York."
      @adventure.score = 0
    end

    @adventure.save
  end

  #puts end of game message with final wallet total
  def end_of_game_message
    puts "You finished the day with $#{@adventure.wallet_now} left in your wallet. Nice job!"
    puts "Your score:  #{@adventure.score_calculator}."
  end

end
