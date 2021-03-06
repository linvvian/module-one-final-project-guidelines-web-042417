class User < ActiveRecord::Base
  include Speak

  has_many :adventures

  def get_set_name
    prompt_for_name
    self.name = gets.chomp
  end

  def self.new_user?
    u = User.new
    puts "------------------------------------------------"
    puts 'Is this your first adventure?'.yellow
    puts 'Please enter: Yes or No'.cyan
    puts "------------------------------------------------"
    input = gets.chomp
    if input.downcase == "yes" || input.downcase == 'y'
      u.get_set_name
      u = u.create_user
    elsif input.downcase == "no" || input.downcase == 'n'
      u.get_set_name
      u = u.find_user
    elsif input.downcase == "back"
      system('clear')
      CommandLineInterface.new.greet
    elsif input.downcase == "exit"
      exit
    else
      u.not_valid_input
      self.new_user?
    end
    u
  end

  def create_user
    new_player = User.where(name: self.name).first_or_create
    puts "------------------------------------------------"
    puts "Thank you for registering!".yellow
    puts "You\'re all set".yellow
    puts "------------------------------------------------"
    new_player
  end

  def find_user
    found = User.find_by(name: self.name)
    if found == nil
      puts "------------------------------------------------"
      puts "Could not find your username.".yellow
      puts "Try again or create new usernam.".yellow
      puts "------------------------------------------------"
      User.new_user?
    else
      puts "------------------------------------------------"
      puts "Found your username!".light_magenta.blink
      puts "------------------------------------------------"
      found
    end
  end

  def set_high_score?(adventure)
    score = adventure.score_calculator
    if score > self.high_score
      self.high_score = score
      self.save
      puts ""
      puts "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
      puts "Woo! You set a new personal high score #{self.high_score}".light_magenta.blink
      puts "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
    else
      puts "------------------------------------------------"
      puts "YOUR HIGH SCORE IS: #{self.high_score}".yellow
      puts "------------------------------------------------"
    end
  end
end
