class Neighborhood
  include Speak

  @hood = 0

  def self.choose_neighborhood
    a = Neighborhood.new
    puts "------------------------------------------------"
    puts "Choose your neighborhood".yellow
    puts "Please Pick A Number".yellow
    puts "And Press Return".yellow
    puts "------------------------------------------------"
    puts " 1 - Financial District".cyan
    puts " 2 - East Village".cyan
    puts " 3 - Greenpoint".cyan
    puts " 4 - Downtown Brooklyn".cyan
    puts " 5 - Astoria".cyan
    puts " 6 - Flushing".cyan
    puts " 7 - Staten Island".cyan
    puts " 8 - Bronx".cyan
    puts " 9 - Jersey City".cyan
    puts "------------------------------------------------"
    puts ''
    input = gets.chomp
    case input
    when 1 # financial_district
      puts "------------------------------------------------"
      puts "Welcome To The Financial District".yellow
      puts "Really? You're here everyday.".yellow
      puts "Alright, let's go.".yellow
      puts "------------------------------------------------"
      @hood = 1
    when 2 #east_village
      puts "------------------------------------------------"
      puts "Welcome To The East Village".yellow
      puts "Good call. Let's get started.".yellow
      puts "------------------------------------------------"
      @hood = 2
    when 3 #greenpoint
      puts "------------------------------------------------"
      puts "Welcome To Greenpoint".yellow
      puts "Home of NYC's best pierogies.".yellow
      puts "Let's get started!".yellow
      puts "------------------------------------------------"
      @hood = 3
    when 4 #downtown_brooklyn
      puts "------------------------------------------------"
      puts "Welcome To Downtown Brooklyn".yellow
      puts "Home of my beloved NY Islanders.".yellow
      puts "Let's get going!".yellow
      puts "------------------------------------------------"
      @hood = 4
    when 5 #astoria
      puts "------------------------------------------------"
      puts "Welcome To Astoria".yellow
      puts "Such good food. Maybe the R train won't".yellow
      puts "break on the way up!".yellow
      puts "------------------------------------------------"
      @hood = 5
    when 6 #flushing
      puts "------------------------------------------------"
      puts "Welcome To Flushing".yellow
      puts "Home of the Metropolitans. Let's go!".yellow
      puts "------------------------------------------------"
      @hood = 6
    when 7 #staten_island
      puts "------------------------------------------------"
      puts "Welcome To Staten Island".yellow
      puts "Grab a beer on the ferry!".yellow
      puts "------------------------------------------------"
      @hood = 7
    when 8 #bronx
      puts "------------------------------------------------"
      puts "Welcome To The Bronx".yellow
      puts "Let's go Yanks!".yellow
      puts "------------------------------------------------"
      @hood = 8
    when 9
      puts "------------------------------------------------"
      puts "New Jersey is not part of NYC. Duh...".light_red.blink
      puts "------------------------------------------------"
      choose_neighborhood
    else
      a.not_valid_input
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
