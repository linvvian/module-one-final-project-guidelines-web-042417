class CommandLineInterface

  def initialize
    @adventure = Adventure.new()
    @user = User.new()
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
      # @adventure
      puts "Please enter your name:"
      puts puts "Hi #{@user.get_set_name}!"
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
    if @adventure.wallet > 0.0 #should be done in adventure class
      if @round <= 3
        @adventure.display_wallet
        @adventure.give_options
        prompt_user_for_choice
        @adventure.calculate_meal
        @round += 1
        round_start
      else
        end_of_game_message
      end
    else
      puts "Game over, you're broke! Welcome to New York."
    end
  end

  #puts end of game message with final wallet total
  def end_of_game_message
    puts "You finished the day with $#{@adventure.wallet} left in your wallet. Nice job!"
  end

end
