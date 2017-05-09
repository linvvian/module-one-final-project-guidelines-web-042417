class User < ActiveRecord::Base
  has_many :adventures

  attr_accessor :name

  def get_set_name
    self.name = gets.chomp
  end
end
