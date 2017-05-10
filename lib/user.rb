class User < ActiveRecord::Base
  include Speak

  has_many :adventures

  def get_set_name
    prompt_for_name
    self.name = gets.chomp
  end

  def self.new_user?
    u = User.new
    puts "Is this your first adventure? (y)es or (n)o"
    input = gets.chomp
    if input.downcase == "y"
      u.get_set_name
      u = u.create_user
    elsif input.downcase == "n"
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
    puts "Now you're registered"
    new_player
  end

  def find_user
    found = User.find_by(name: self.name)
    if found == nil
      puts "Could not find. Try again or create new."
      User.new_user?
    else
      puts "Found you!"
      found
    end
  end

  def set_high_score?(score)
    if score > self.high_score
      self.high_score = score
      self.save
      puts "Congratz! You set a new personal high score #{self.high_score}"
      puts "=================PLACEHOLDER==================="
    end
    puts "YOUR HIGH SCORE IS: #{self.high_score}"
    puts "=================PLACEHOLDER==================="
  end

end
