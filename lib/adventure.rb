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
    puts "You have $#{self.wallet} in your wallet."
    puts "Let's get started!"
    puts "---------------------------------"
  end

  def price_calculate
    price = gets_option_choice.price
    wallet_hit = 0.00
    case price
    when 1
      wallet_hit = 8.00
    when 2
      wallet_hit = 10.00
    when 3
      wallet_hit = 12.00
    when 4
      wallet_hit = 15.00
    when 5
      wallet_hit = 20.00
    else
      wallet_hit = 30.00
    end
    wallet_hit
  end

  def calculate_meal
    self.wallet -= price_calculate
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
end
