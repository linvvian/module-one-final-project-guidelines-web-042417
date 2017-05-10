class Adventure < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants

  attr_accessor :wallet, :score

  def initialize(wallet = 30.00)
    @wallet = wallet
    @array = []
  end

# put in CLI
  def display_wallet # this is getting called every round - we should change that
    puts "---------------------------------"
    puts "You have $#{self.wallet.round(2)} in your wallet."
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
    self.wallet -= price_calculate
    if self.wallet < 0.0
      puts "You don't have enough money! You went over by $#{(self.wallet * -1)}. Time to WASH DISHES!"
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
    input = input.to_i
    input -= 1
    @array[input]
  end

  def prompt_give_tip
    puts "Do you want to see tips? Enter: yes or no"
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

  def random_event
    num = rand(1..10)
    case num
    when 2
      lost_wallet
    end
  end

  def lost_wallet
    puts "Oh no! You lost your wallet!"
    self.wallet = 0.0
  end
end
