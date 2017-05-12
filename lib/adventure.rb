class Adventure < ActiveRecord::Base
  include Speak

  belongs_to :user
  has_many :meal_choices
  has_many :restaurants, through: :meal_choices

  attr_accessor :start_wallet, :array

  def self.start_new_adventure(userID)
    adventure = Adventure.create
    #adventure.count = 1
    adventure.score = 0
    adventure.start_wallet = 30.00
    adventure.wallet = adventure.start_wallet
    adventure.array = []
    adventure.tap {|adventure| adventure.user_id = userID}
  end

  def self.begin_round(adventure, round)
    adventure.display_wallet
    adventure.options_for_meals(round)
    adventure.give_options
    adventure.calculate_meal
    adventure.reset_choice_array
    adventure.random_event if adventure.wallet > 0.0 && round != 3
  end

  def display_wallet
    puts "_________________________________________".green
    puts "|\\__________________^__________________/|".green
    puts "| ----------------  ^  ---------------- |".green
    puts "| You have $#{self.wallet.round}      ^    in your wallet |".green
    puts "| ----------------  ^  ---------------- |".green
    puts "|___________________^___________________|".green
  end

  def price_calculate
    price = gets_option_choice.price
    wallet_hit = 0.00
    case price
    when 1
      wallet_hit = rand(5.0..8.0).round(2)
    when 2
      wallet_hit = rand(10.0..13.0).round(2)
    when 3
      wallet_hit = rand(14.0..16.0).round(2)
    when 4
      wallet_hit = rand(17.0..19.0).round(2)
    when 5
      wallet_hit = rand(20.0..25.0).round(2)
    else
      wallet_hit = 30.00
    end
    wallet_hit
  end

  def calculate_meal
    self.wallet -= price_calculate
    if self.wallet < 0.0
      puts "------------------------------------------------"
      puts "You don't have enough money!".light_red
      puts "You went over by $#{(self.wallet.round(2) * -1)}.".green
      puts "Time to WASH DISHES!".light_red
      puts "------------------------------------------------"
    elsif self.wallet == 0.0
      puts "------------------------------------------------"
      puts "You just blew all your money.".light_red.blink
      puts "Good luck getting through the rest of you day".light_red.blink
      puts "------------------------------------------------"
    end
  end

  def give_options
    for i in 1..3
      option = Restaurant.random_restaurant
      puts '<><><><><><><><><><><><><><><><><><><><><><><><>'
      puts "- #{i}".cyan
      puts "- Name: #{option.name}".cyan
      puts "- Category: #{option.category}".cyan
      puts "- Rating: #{option.rating}".cyan
      puts '<><><><><><><><><><><><><><><><><><><><><><><><>'
      @array << option
    end
  end

  def gets_option_choice
    input = gets.chomp
    if input == 'blurb'
      prompt_give_tip
      choose_restaurant_message
      gets_option_choice
    elsif input.to_i == 0 || input.to_i > 3 || input.to_i < 0
      not_valid_input
      choose_restaurant_message
      gets_option_choice
    else
      input = input.to_i
      input -= 1
      chosen = @array[input]
      MealChoice.chosen_meal(self.id, chosen.id)
      chosen
    end
  end

  def prompt_give_tip
    @array.each.with_index do |rest, index|
      puts "====="
      puts "- #{index+1} - #{rest.name} - Blurb: #{rest.tips}".cyan
      puts "====="
    end
    puts ""
  end

  def reset_choice_array
    @array.clear
  end

  def score_calculator
    self.score = (self.wallet.round(2) / @start_wallet) * 10000
    self.score = self.score.round
  end

  def self.show_high_scores
    highs = self.all.order(score: :desc).limit(5).pluck(:user_id, :score)
    counter = 1
    puts @@d.asciify('LEADERBOARD').light_magenta.bold
    highs.each do |pair|
      puts "................................................"
      puts " * (#{counter}) #{User.find(pair[0]).name} - #{pair[1]} pts *".green
      counter += 1
    end
    puts "................................................"
    puts ""
  end

  def random_event
    number = rand(1..10)
    case number
    when 4
      lost_wallet
    when 1
      display_wallet
      found_money
    when 3
      display_wallet
      comes_homeless
    when 2
      display_wallet
      tourist_encounter
    end
    #@count += 1
  end

  def lost_wallet
    stolen_wallet_message
    self.wallet = 0.0
  end

  def found_money
    puts "------------------------------------------------"
    puts "You see the old lady in front of you drop".yellow
    puts "$20.00 on the floor in the lobby.".yellow
    puts "Do you:".yellow
    puts "------------------------------------------------"
    puts " 1 - Keep it".cyan
    puts " 2 - Return it".cyan
    puts " 3 - Wait, see if she notices, if not, keep it".cyan
    puts "------------------------------------------------"
    puts ''
    input = gets.chomp
    case input.to_i
    when 1
      self.wallet += 20.00
      self.wallet -= 30.00
      puts "------------------------------------------------"
      puts "Nice! You got an extra 20 bucks.".green
      puts "But you lost your MetroCard that had $30 in it,".light_red
      puts "you need to buy another one.".light_red
      puts "------------------------------------------------"
    when 2
      puts "------------------------------------------------"
      puts "Good for you. The old lady appreciated it.".yellow
      puts "She offers you some chocolate.".green
      puts "------------------------------------------------"
    when 3
      puts "------------------------------------------------"
      puts "Really?".yellow
      puts "Well, lucky for you the old lady didn't notice".yellow
      puts "so you got an extra $20.".green
      puts "Your old buddy from college drops by".yellow
      puts "and you guys go grab some coffee.".yellow
      puts "But you have to pay for it, so -$25.".light_red
      puts "(Your buddy only drinks the 'nice' stuff...)".yellow
      puts "------------------------------------------------"
      self.wallet += 20.00
      self.wallet -= 25.00
    else
      not_valid_input
      found_money
    end
  end

  def comes_homeless
    money_given = 0
    counter = 6
    puts "------------------------------------------------"
    puts "A homeless guy approaches you, asking for money.".yellow
    puts "What do you do?".yellow
    puts "------------------------------------------------"
    while self.wallet > 0.0 && money_given < 10.00
      puts "------------------------------------------------"
      puts " 1 - Give him $1.00".cyan
      puts " 2 - Ignore him".cyan
      puts " 3 - Give him $5.00".cyan
      puts " 4 - Homeless Roulette".black
      puts "------------------------------------------------"
      input = gets.chomp
      case input.downcase
      when "1"
        self.wallet -= 1.00
        puts "------------------------------------------------"
        puts "The homeless guy happily snatches your dollar.".light_red
        puts "But at the next stop light, there he is again...".yellow
        puts "What do you do?".yellow
        puts "------------------------------------------------"
        money_given += 1
        display_wallet
      when "2"
        puts "------------------------------------------------"
        puts "You ignore the homeless guy...".yellow
        sleep(1)
        puts "He continues to follow you...".yellow
        sleep(1)
        puts "What do you do?".yellow
        puts "------------------------------------------------"
      when "3"
        self.wallet -= 5.00
        puts "------------------------------------------------"
        puts "Good for you. Homeless guy leaves.".yellow
        puts "------------------------------------------------"
        break
      when "roulette", "r", "4"
        puts ""
        puts "DING DING DING"
        puts "Prepare for battle!!!!".yellow
        puts "You face off the homeless man in a game of".yellow
        puts "Russian Roulette".yellow
        puts "You go first".yellow
        puts ""
        russian_roulette(counter, money_given)
        break
      else
        not_valid_input
      end
    end
    if self.wallet < 0.0
      puts ""
      puts "------------------------------------------------"
      puts "You ran out of money... Homeless guy leaves.".red.blink
      puts "------------------------------------------------"
      puts ""
    elsif money_given == 10.00
      puts "------------------------------------------------"
      puts "Wow. Really?"
      sleep(1)
      puts "The homeless guy happily goes away and finally".yellow
      puts "leaves you alone.".yellow
      puts "But you lost $10 dollars. Good job!".yellow
      puts "------------------------------------------------"
    end
  end

  def russian_roulette(counter, money)
    while counter != 1
      puts "Your turn".yellow
      STDIN.getch
      chance = rand(1..counter)
      if chance == 1
        puts "*bang*".light_red
        puts "You died. He takes all your $$".light_red
        puts ""
        self.wallet = 0.0
        break
      end
      puts "*CLICK*"
      puts ""
      counter -= 1
      sleep(1)
      puts "His turn".yellow
      puts ""
      sleep(1.5)
      chance = rand(1..counter)
      if chance == 1
        picked_up = rand(5.0..15.0)
        picked_up = picked_up.round(2)
        puts "*bang*".light_red
        puts "HE DIES".light_red
        puts "Lucky you. You got your money back: $#{money} and you got from the homeless guy $#{picked_up}.".green
        self.wallet = self.wallet + money + picked_up
        break
      end
      puts "*CLICK*"
      puts ""
      counter -= 1
    end
  end

  def tourist_encounter
      puts "------------------------------------------------"
      puts "A tourist asks for directions to Times Square.".yellow
      puts "Do you:".yellow
      puts "------------------------------------------------"
      puts " 1 - Give him instructions on how to get there".cyan
      puts " 2 - Lie to him and tell him you don't know".cyan
      puts " 3 - Deliberately mislead him to Jersey".cyan
      puts "------------------------------------------------"
      puts ''
      input = gets.chomp
      case input.to_i
      when 1
        puts "------------------------------------------------"
        puts "How nice of you! He's walks off happily.".yellow
        puts "On your way to the restaurant you find a crisp".green
        puts "5 dollar bill on the ground. Score!".green
        puts "------------------------------------------------"
        self.wallet += 5.00
      when 2
        puts "------------------------------------------------"
        puts "Nice. Time is money, and you can't be bothered.".yellow
        puts "Wait, where's your wallet????".light_red
        puts "That so-called tourist scammed you!".light_red
        puts "------------------------------------------------"
        lost_wallet
      when 3
        puts "------------------------------------------------"
        puts "How cruel of you. All he wanted was to see the".yellow
        puts "neon billboards, sketchy Elmos and maybe".yellow
        puts "grab an overpriced meal at Bubba Gump Shrimp".yellow
        puts "Company.".yellow
        puts "Hmmm....actually he's better off in New Jersey.".yellow
        puts "Nice job! Have a penny.".green
        puts "------------------------------------------------"
        self.wallet += 0.01
      else
        not_valid_input
        tourist_encounter
      end
    end
end
