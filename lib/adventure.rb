class Adventure < ActiveRecord::Base
  include Speak

  belongs_to :user
  has_many :meal_choices
  has_many :restaurants, through: :meal_choices

  attr_accessor :wallet_now, :start_wallet, :array

  def self.start_new_adventure(userID)
    adv = Adventure.create
    adv.start_wallet = 30.00
    adv.wallet_now = 30.00
    adv.array = []
    adv.tap {|adv| adv.user_id = userID}
  end

  def display_wallet
    puts "_________________________________________".green
    puts "|\\__________________^__________________/|".green
    puts "| ----------------  ^  ---------------- |".green
    puts "| You have $#{self.wallet_now.round}      ^    in your wallet |".green
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
    self.wallet_now -= price_calculate
    if self.wallet_now < 0.0
      puts "------------------------------------------------"
      puts "You don't have enough money!".light_red
      puts "You went over by $#{(self.wallet_now.round(2) * -1)}.".green
      puts "Time to WASH DISHES!".light_red
      puts "------------------------------------------------"
    end
  end

  def give_options
    for i in 1..3
      option = Restaurant.random_restaurant
      puts '<><><><><><><><><><><><><><><><><><><><><><><>'
      puts "- #{i}".cyan
      puts "- Name: #{option.name}".cyan
      puts "- Category: #{option.category}".cyan
      puts "- Rating: #{option.rating}".cyan
      puts '<><><><><><><><><><><><><><><><><><><><><><><>'
      @array << option
    end
  end

  def gets_option_choice
    input = gets.chomp
    if input == 'blurb'
      prompt_give_tip
      choose_restaurant_message
      gets_option_choice
    elsif input.to_i == 0 || input.to_i > 3
      not_valid_input
      choose_restaurant_message
      gets_option_choice    
    else 
      input = input.to_i
      input -= 1
      chosen = @array[input]
      MealChoice.chosen_meal(self.id, chosen.id) #guess I can be refactored....
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
    self.score = (self.wallet_now.round(2) / @start_wallet) * 10000
    self.score = self.score.round
  end

  def self.show_high_scores
    highs = self.all.order(score: :desc).limit(5).pluck(:user_id, :score)
    counter = 1
    puts @@d.asciify('LEADERBOARD').light_magenta.bold
    highs.each do |pair|
      puts "      _________________________________________________________"
      puts "                            * (#{counter}) #{User.find(pair[0]).name} #{pair[1]} *".green
      counter += 1
    end
    puts "      _________________________________________________________"
  end
  # ^ ^ ^ This method is awesome - so well done...

  def random_event
    num = rand(1..10)
    case num
    when 2
      lost_wallet
    end
  end

  def lost_wallet
    stolen_wallet_message
    self.wallet_now = 0.0
  end
end
