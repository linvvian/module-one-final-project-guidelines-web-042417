class CommandLineInterface

  #greet the user
  def greet
    puts "Welcome to the (title here) game!"
    get_user_name_and_greet_user
  end

  #get the user's name so it can be saved in the database with User model method
  def get_user_name_and_greet_user
    puts "Please enter your name:"
    name = gets.chomp
    puts "Hi #{name}!"
    round_start
  end

  #displays the user's wallet amount at the beginning(amount generated in Adventure class?)
  def display_wallet(amount = 30.00)
    puts "You have $#{amount} in your wallet and three meals to eat! Let's get started!"
  end

  #displays three restaurants
  def show_restaurant_details
    puts "1.#{random_restaurant.name} - #{random_restaurant.type} - #{random_restaurant.rating}"
    puts "2.#{random_restaurant.name} - #{random_restaurant.type} - #{random_restaurant.rating}"
    puts "3.#{random_restaurant.name} - #{random_restaurant.type} - #{random_restaurant.rating}"
  end

  #prompts user for choice and gets user input
  def prompt_user_for_choice
    puts "Please select the restaurant you would like to eat at: 1, 2, or 3"
  end

  #kicks off the second and third rounds with an updated wallet total
  def round_start
    if 5 > 0 #should be done in adventure class
      display_wallet
      show_restaurant_details
      prompt_user_for_choice
    else
      puts "Game over, you're broke! Welcome to New York."
    end
  end

  #puts end of game message with final wallet total
  def end_of_game_message
    puts "You finished the day with $#{current_wallet} left in your wallet. Nice job!"
  end

end
