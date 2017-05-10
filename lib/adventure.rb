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

# put in CLI
  def display_wallet # this is getting called every round - we should change that
    puts "---------------------------------"
    puts "You have $#{self.wallet_now.round(2)} in your wallet."
    puts "Let's get started!"
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
      puts "You don't have enough money! You went over by $#{(self.wallet_now * -1)}. Time to WASH DISHES!"
    end
  end

  def give_options
    for i in 1..3
      option = Restaurant.random_restaurant
      puts '<><><><><><><><><><><><><><><><><><><><><>'
      puts "- (#{i})                                  "
      puts "- Name: #{option.name}                    "
      puts "- Category: #{option.category}            "
      puts "- Rating: #{option.rating}                "
      puts '<><><><><><><><><><><><><><><><><><><><><>'
      @array << option
    end
  end

  def gets_option_choice
    input = gets.chomp
    if input.to_i == 0 || input.to_i > 3
      not_valid_input
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
    puts "Do you want to see blurb from a previous customer? Enter: Yes or No"
    input = gets.chomp
    if input.downcase == "yes" || input.downcase == "y"
      @array.each.with_index do |rest, index|
        puts "Choice #{index+1}. #{rest.name} Tip: #{rest.tips}"
      end
    end
    puts ""
  end

  def reset_choice_array
    @array.clear
  end

  def score_calculator
    @score = (self.wallet_now.round(2) / @start_wallet) * 10000
    @score.round
  end

  def random_event
    num = rand(1..10)
    case num
    when 2
      lost_wallet
    end
  end

  def lost_wallet
    puts "Oh no! You lost your wallet!"
    self.wallet_now = 0.0
  end
end
