class CommandLineInterface
  @@a = Artii::Base.new :font => 'slant'
  @@b = Artii::Base.new :font => 'banner3'
  @@c = Artii::Base.new :font => 'big'
  @@d = Artii::Base.new :font => 'block'
  @@e = Artii::Base.new :font => 'doh'
  @@f = Artii::Base.new :font => 'doom'
  @@g = Artii::Base.new :font => 'epic'
  @@h = Artii::Base.new :font => 'isometric1'
  @@i = Artii::Base.new :font => 'isometric2'
  


  def initialize
    @adventure = Adventure.new()
    @user = User.new()
    @round = 1
  end

  #greet the user
  def greet
    puts @@h.asciify('Don\'t Let NYC')
    puts @@i.asciify('Take Your Money!')
    puts ''
    puts "############################################"
    puts "#                                          #"
    puts "# Welcome to the (title here) game!        #"
    puts "#                                          #"
    puts "# We all know NYC costs way to much. It    #"
    puts "# seems like every meal you eat also takes #"
    puts "# takes a bit out of you.                  #"
    puts "#                                          #"
    puts "# So, here is a game designed to help      #"
    puts "# you adjust to eating in the many         #"
    puts "# neighborhoods NYC.                       #"
    puts "#                                          #"
    puts "# Try to make it through your week and     #"
    puts "# still have money left in your wallet.    #"
    puts "#                                          #"
    puts "#               GOOD LUCK!!!               #"
    puts "#                                          #"
    puts "############################################"
    choose_adventure
  end

  def choose_adventure
    puts ''
    puts "---------------------------------"
    puts " Please Pick A Number"
    puts " (Or Don't - It's Your Life...)"
    puts "---------------------------------"
    puts ''
    puts " (1) - Start your adventure -"
    puts " (2) - I do nothing         -"
    puts " (3) - Exit                 -"
    puts ''
    input = gets.chomp
    case input
    when "1"
      # @adventure
      puts "---------------------------------"
      puts "Please enter your name:"
      puts "---------------------------------"
      puts ''
      puts @@c.asciify("Hi #{@user.get_set_name}!") 
      round_start
    when "3"
      exit
    else
      puts @@e.asciify('NOT VALID!')
      choose_adventure
    end
  end

  #prompts user for choice and gets user input
  def prompt_user_for_choice
    puts "---------------------------------"
    puts "Please select the restaurant"
    puts "you would like to eat at:"
    puts "(1, 2, or 3)"
    puts "---------------------------------"
  end

  def round_start
    if @adventure.wallet > 0.0 #should be done in adventure class
      if @round <= 3
        @adventure.display_wallet
        @adventure.give_options
        prompt_user_for_choice
        @adventure.calculate_meal
        @round += 1
        round_start
      else
        end_of_game_message
      end
    else
      puts @@b.asciify('Game over, you\'re broke!')
      puts ''
      puts @@b.asciify('Welcome to New York.')
    end
  end

  #puts end of game message with final wallet total
  def end_of_game_message
    puts @@b.asciify('You finished the day with')
    puts ''
    puts @@b.asciify("$#{@adventure.wallet}")
    puts ''
    puts @@b.asciify('left in your wallet.')
    puts ''
    puts @@b.asciify('Nice job!!!')
  end

end
