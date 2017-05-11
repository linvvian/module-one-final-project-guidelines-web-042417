class Neighborhood
  include Speak

  @hood = 0

  def self.choose_neighborhood
    puts "Choose your neighborhood:"
    puts "1. Financial District"
    puts "2. East Village"
    puts ""
    puts "Enter 1 for Financial District or 2 for East Village"
    input = gets.chomp
    case input
    when "1" # financial_district
      puts "Really? Alright, let's go."
      @hood = 1
    when "2" #east_village
      puts "Good call. Let's get started."
      @hood = 2
    when "3" #greenpoint
      puts "The best. I'm comin home momma."
      @hood = 3
    when "4" #downtown_brooklyn
      puts "Also quite nice. Here we go."
      @hood = 4
    when "5" #astoria
      puts "Nice, the Sandwich King rules. Have fun."
      @hood = 5
    when "6" #flushing
      puts "Let's go Mets?"
      @hood = 6
    when "7" #staten_island
      puts "Grab a beer on the ferry. Good call"
      @hood = 7
    when "8" #bronx
      puts "Let's go Yanks"
      @hood = 8
    when "9"
      puts "New Jersey is not part of this. Duh..."
      choose_neighborhood
    else
      puts "Who taught you how to choose? Pick again."
      choose_neighborhood
    end
  end

  def self.picks_hood
    case @hood
    when 1
      rand(1..50)
    when 2
      rand(51..100)
    when 3
      rand(101..150)
    when 4
      rand(151..200)
    when 5
      rand(201..250)
    when 6
      rand(251..300)
    when 7
      rand(301..350)
    when 8
      rand(351..378)
    end
  end
end
