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

  def self.begin_round(adv, round)
    adv.display_wallet
    adv.options_for_meals(round)
    adv.give_options
    adv.calculate_meal
    adv.reset_choice_array
    adv.random_event
  end

  def display_wallet
    puts "---------------------------------"
    puts "You have $#{self.wallet_now.round(2)} in your wallet."
    puts "---------------------------------"
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
      puts "You don't have enough money! You went over by $#{(self.wallet_now.round(2) * -1)}. Time to WASH DISHES!"
      puts  "======================PLACEHOLDER======================="
      return
    end
  end

  def give_options
    for i in 1..3
      option = Restaurant.random_restaurant
      puts '<><><><><><><><><><><><><><><><><><><><><>'
      puts "- #{i}                                    "
      puts "- Name: #{option.name}                    "
      puts "- Category: #{option.category}            "
      puts "- Rating: #{option.rating}                "
      puts '<><><><><><><><><><><><><><><><><><><><><>'
      @array << option
    end
  end

  def gets_option_choice
    input = gets.chomp
    if input == 'blurb'
      prompt_give_tip
      choose_restaurant_message
      gets_option_choice
    elsif input.to_i == 0 || input.to_i > 3 && input.to_i < 0
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
      puts " #{index+1} - #{rest.name} - Blurb: #{rest.tips}"
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
    highs.each do |pair|
      puts "#{User.find(pair[0]).name} #{pair[1]}"
      puts  "======================PLACEHOLDER======================="
    end
  end

  def random_event
    display_wallet
    num = rand(1..10)
    case num
    when 2
      lost_wallet
    when 4
      found_money
    end
  end

  def lost_wallet
    stolen_wallet_message
    self.wallet_now = 0.0
  end

  def found_money
    puts "You see the old lady in front of you drop $20.00 on the floor in the lobby."
    puts "Do you:"
    puts "1 Keep it"
    puts "2 Return it"
    puts "3 Wait to see if she notices, then if not keep it"
    input = gets.chomp
    case input.to_i
    when 1
      self.wallet_now += 20.00
      self.wallet_now -= 30.00
      puts "Nice! You got an extra 20 bucks."
      puts "But you lost your MetroCard that had $30 in it and you need to buy another one."
    when 2
      puts "Good for you. The old lady appreciated it. She offers you some chocolate."
    when 3
      puts "Really?"
      puts "Well, lucky for you the old lady didn't notice so you got an extra $20."
      puts "Your old buddy from college drops by and so you guys go grab some coffee."
      puts "But you have to pay for it so -$15."
      self.wallet_now += 20.00
      self.wallet_now -= 15.00
    else
      puts "INVALID INPUT"
      found_money
    end
  end

end
