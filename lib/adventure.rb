class Adventure < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants

  attr_accessor :wallet, :score

  def initialize(wallet = 30.00)
    @wallet = wallet
  end

  def display_wallet
    puts "You have $#{self.wallet} in your wallet and three meals to eat! Let's get started!"
  end
end
