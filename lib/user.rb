class User < ActiveRecord::Base
  has_many :adventures

  def get_set_name
    puts "Please enter your name:"
    self.name = gets.chomp
  end

  def self.new_user?
    u = User.new
    puts "Is this your first adventure? (y)es or (n)o"
    input = gets.chomp
    if input.downcase == "y"
      u.get_set_name
      u.create_user
    elsif input.downcase == "n"
      u.get_set_name
      u.find_user
      puts "Found you!"
    else
      puts "Invalid input"
      self.new_user?
    end
    puts "Hi #{u.name}!"
    u
  end

  def create_user
    User.where(name: self.name).first_or_create
    puts "Now you're registered"
  end

  def find_user
    found = User.find_by(name: self.name)
    if nil == found
      puts "Could not find. Try again or create new."
      User.new_user?
    end
  end

end
