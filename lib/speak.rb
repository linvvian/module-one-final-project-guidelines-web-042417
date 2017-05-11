module Speak
  # load ASCII fonts
  @@a = Artii::Base.new :font => 'univers'
  @@b = Artii::Base.new :font => 'banner3'
  @@c = Artii::Base.new :font => 'big'
  @@d = Artii::Base.new :font => 'slant'
  @@e = Artii::Base.new :font => 'doh'
  @@f = Artii::Base.new :font => 'lean'
  @@g = Artii::Base.new :font => 'epic'
  @@h = Artii::Base.new :font => 'isometric2'
  @@i = Artii::Base.new :font => 'isometric1'


  def greet_and_rules
    puts @@a.asciify('DON\'T LET NYC')
    puts @@a.asciify('TAKE YOUR MONEY').colorize(:light_red)
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
    puts "#############################################"
    puts ""
    puts "                  GOOD LUCK!                 ".light_magenta.bold.blink
    puts ""
  end

  def not_valid_input
    puts @@e.asciify("NOT VALID!").light_black
  end

  def snarky_response
    puts @@g.asciify("ARE YOU HAPPY NOW?!").light_red.blink
  end

  def main_menu
    puts "------------------------------------------------"
    puts " Please Pick A Number".yellow
    puts " And Press Return".yellow
    puts " (Or Don't - It's Your Life...)".yellow
    puts "------------------------------------------------"
    puts " 1 - Start your adventure".cyan
    puts " 2 - I do nothing".cyan
    puts " 3 - Leaderboard".cyan
    puts " 4 - Top 5 Restaurants".cyan
    puts " 5 - Exit".cyan
    puts "------------------------------------------------"
  end

  def prompt_for_name
    puts "------------------------------------------------"
    puts "Please enter your name:".yellow
    puts "------------------------------------------------"
  end

  def choose_restaurant_message
    puts "------------------------------------------------"
    puts "Please choose a restaurant:".yellow
    puts "------------------------------------------------"
  end

  def get_name(user_name)
    puts ''
    puts @@c.asciify("Hi  #{user_name}!").light_magenta.bold
  end

  def options_for_meals(round)
    meal_time = ''
    case round
    when 1
      meal_time = "Breakfast"
    when 2
      meal_time = "Lunch"
    when 3
      meal_time = "Dinner"
    end
    puts "------------------------------------------------"
    puts "It\'s time for #{meal_time}!".yellow
    puts ''
    puts "Below are 3 restaurants.".yellow
    puts "Enter the number that corresponds to".yellow
    puts "the restaurant where you would like to eat.".yellow
    puts ''
    puts "If you would like to see a blurb about".yellow 
    puts "the restuarant from a previous" .yellow
    puts "patron, enter \"blurb\"".yellow
    puts "------------------------------------------------"
  end

  def lost_end_game_message
    puts @@b.asciify('  Welcome to New York.').blue
    puts ''
    puts @@b.asciify('          You\'re broke!')
    puts ''
    puts@@b.asciify('               GAME OVER').light_red
  end

  def stolen_wallet_message
    puts @@g.asciify("SOMEONE STOLE YOUR WALLET!").light_red.blink
  end

  def return_main_menu_message
    puts ""
    puts "------------------------------------------------"
    puts "HIT ANY KEY TO RETURN TO THE MAIN MENU".cyan
    puts "------------------------------------------------"
  end

  def finished_end_of_game_message
    puts @@b.asciify('You finished the day with').yellow
    puts ''
    puts @@b.asciify("$#{@adventure.wallet_now.round(2)}").green
    puts ''
    puts @@b.asciify('left in your wallet.').yellow
    puts ''
    puts @@b.asciify('Nice job!!!').light_magenta
  end

  def goodbye_message
    sleep(2)
    puts "#########################################"
    puts "#     Sorry you don't want to play.     #" 
    puts "# Guess you have better things to do... #"
    puts "#########################################"
    puts""
    sleep(2)
    puts @@h.asciify("goodbye").light_red.on_blue
    puts @@i.asciify("forever").light_red.on_blue
    puts""
  end
end




