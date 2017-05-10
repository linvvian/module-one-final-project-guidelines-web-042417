module Speak
  # load ASCII fonts
  @@a = Artii::Base.new :font => 'slant'
  @@b = Artii::Base.new :font => 'banner3'
  @@c = Artii::Base.new :font => 'big'
  @@d = Artii::Base.new :font => 'block'
  @@e = Artii::Base.new :font => 'doh'
  @@f = Artii::Base.new :font => 'doom'
  @@g = Artii::Base.new :font => 'epic'
  @@h = Artii::Base.new :font => 'isometric1'
  @@i = Artii::Base.new :font => 'isometric2'

  def greet_and_rules
    puts @@h.asciify('Don\'t Let NYC')
    puts @@i.asciify('Take Your Money!')
    puts ''
    puts "############################################"
    puts "#                                          #"
    puts "# Welcome to the (title here) game!        #"
    puts "#                                          #"
    puts "# We all know NYC costs way too much. It   #"
    puts "# seems like every meal you eat also takes #"
    puts "# takes a bite out of you.                 #"
    puts "#                                          #"
    puts "# Here is a game designed to help          #"
    puts "# you adjust to eating in the many         #"
    puts "# neighborhoods throughout NYC.            #"
    puts "#                                          #"
    puts "# Try to make it through your week and     #"
    puts "# still have money left in your wallet.    #"
    puts "#                                          #"
    puts "#               GOOD LUCK!!!               #"
    puts "#                                          #"
    puts "############################################"
  end

  def not_valid_input
    puts @@e.asciify("NOT VALID!")
  end

  def main_menu
    puts ''
    puts "---------------------------------"
    puts " Please Pick A Number"
    puts " (Or Don't - It's Your Life...)"
    puts "---------------------------------"
    puts ''
    puts " 1 - Start your adventure -"
    puts " 2 - I do nothing         -"
    puts " 3 - Exit                 -"
    puts ''
  end

  def get_and_display_user_name(user_name)
      puts "---------------------------------"
      puts "Please enter your name:"
      puts "---------------------------------"
      puts ''
      puts @@c.asciify("Hi #{user_name}!") 
  end

  def prompt_user_for_choice
    puts "---------------------------------"
    puts "Please select the restaurant"
    puts "you would like to eat at:"
    puts "(1, 2, or 3)"
    puts "---------------------------------"
  end

  def lost_end_game_message
    puts @@b.asciify('Game over, you\'re broke!')
    puts ''
    puts @@b.asciify('Welcome to New York.')
  end

  def finished_end_of_game_message
    puts @@b.asciify('You finished the day with')
    puts ''
    puts @@b.asciify("$#{@adventure.wallet}")
    puts ''
    puts @@b.asciify('left in your wallet.')
    puts ''
    puts @@b.asciify('Nice job!!!')
  end

end