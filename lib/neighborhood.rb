class Neighborhood
  include Speak

  def self.choose_neighborhood
    puts "Choose your neighborhood:"
    puts "1. Financial District"
    puts "2. East Village"
    puts ""
    puts "Enter 1 for Financial District or 2 for East Village"
    input = gets.chomp
    case input
    when "1"
      puts "Really? Alright, let's go."
      Adapter.financial_district
    when "2"
      puts "Good call. Let's get started."
      Adapter.east_village
    else
      puts "Who taught you how to choose? Pick again."
      choose_neighborhood
    end
  end

end
