class User < ActiveRecord::Base
  include Speak

  has_many :adventures

  def get_set_name
    prompt_for_name
    self.name = gets.chomp
  end

  def self.new_user?
    u = User.new
    puts "---------------------------------"
    puts 'Is this your first adventure?'
    puts 'Please enter: Yes or No' 
    puts "---------------------------------"
    input = gets.chomp
    if input.downcase == "yes"
      u.get_set_name
      u = u.create_user
    elsif input.downcase == "no"
      u.get_set_name
      u = u.find_user
    else
      u.not_valid_input
      self.new_user?
    end
    u
  end

  def create_user
    new_player = User.where(name: self.name).first_or_create
    puts "---------------------------------"
    puts "Thank you for registering!" 
    puts "You\'re all set"
    puts "---------------------------------"
    new_player
  end

  def find_user
    found = User.find_by(name: self.name)
    if found == nil
      puts "---------------------------------"
      puts "Could not find your username." 
      puts "Try again or create new usernam."
      puts "---------------------------------"
      User.new_user?
    else
      puts "---------------------------------"
      puts "Found your username!"
      puts "---------------------------------"
      found
    end   
  end
end
