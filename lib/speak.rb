module Speak
  # load ASCII fonts
  @@a = Artii::Base.new :font => 'univers'
  @@b = Artii::Base.new :font => 'banner3'
  @@c = Artii::Base.new :font => 'big'
  @@e = Artii::Base.new :font => 'doh'
  @@f = Artii::Base.new :font => 'lean'
  @@g = Artii::Base.new :font => 'epic'


  def greet_and_rules
    puts @@a.asciify('DON\'T LET NYC')
    puts @@a.asciify('TAKE YOUR MONEY')
    puts ''
    puts "#############################################"
    puts "#                                           #"
    puts "#                Welcome to:                #"
    puts "#                                           #"
    puts "#    \"DON\'T LET NYC TAKE YOUR MONEY\"        #"
    puts "#                                           #"
    puts "#   We all know NYC costs way too much. It  #"
    puts "#  seems like every meal you eat also takes #"
    puts "#         takes a bite out of you.          #"
    puts "#                                           #"
    puts "#      Here is a game designed to help      #"
    puts "#      you adjust to eating in the many     #"
    puts "#       neighborhoods throughout NYC.       #"
    puts "#                                           #"
    puts "#   Try to make it through your week and    #"
    puts "#   still have money left in your wallet.   #"
    puts "#                                           #"
    puts "#               GOOD LUCK!!!                #"
    puts "#                                           #"
    puts "#############################################"
  end

  def not_valid_input
    puts @@e.asciify("NOT VALID!")
  end

  def snarky_response
    puts @@g.asciify("ARE YOU HAPPY NOW?!")
  end

  def return_main_menu_message
    "Press Enter To Return To Main Menu"
  end

  def main_menu
    puts ''
    puts "---------------------------------"
    puts " Please Pick A Number"
    puts " And Press Return"
    puts " (Or Don't - It's Your Life...)"
    puts "---------------------------------"
    puts " 1 - Start your adventure "
    puts " 2 - I do nothing         "
    puts " 3 - Exit                 "
    puts "---------------------------------"
    puts ''
  end

  def prompt_for_name
    puts "---------------------------------"
    puts "Please enter your name:"
    puts "---------------------------------"
  end

  def choose_restaurant_message
    puts "---------------------------------"
    puts "Please choose a restaurant:"
    puts "---------------------------------"
  end

  def get_name(user_name)
    puts ''
    puts @@c.asciify("Hi  #{user_name}!")
  end

  def options_for_meals(round)
    meal_time = ''
    case round
    when 1
      meal_time = "Breakfast"
    when 1
      meal_time = "Lunch"
    when 1
      meal_time = "Dinner"
    end
    puts "------------------------------------------------"
    puts "It\'s time for #{meal_time}!"
    puts ''
    puts "Below are 3 restaurants."
    puts "Enter the number that corresponds to"
    puts "the restaurant where you would like to eat."
    puts ''
    puts "If you would like to blurb about the restuarant"
    puts "from a previous patron enter \"blurb\""
    puts "------------------------------------------------"
  end

  def lost_end_game_message
    puts @@b.asciify('Welcome to New York.')
    puts ''
    puts @@b.asciify('You\'re broke!')
    puts ''
    puts@@b.asciify('        GAME OVER')
  end

  def stolen_wallet_message
    @@g.asciify("SOMEONE STOLE YOUR WALLET!")
  end

  def finished_end_of_game_message
    puts @@b.asciify('You finished the day with')
    puts ''
    puts @@b.asciify("$#{@adventure.wallet_now.round(2)}")
    puts ''
    puts @@b.asciify('left in your wallet.')
    puts ''
    puts @@b.asciify('Nice job!!!')
  end

end
