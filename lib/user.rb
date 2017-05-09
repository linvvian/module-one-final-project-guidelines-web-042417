class User < ActiveRecord::Base
  has_many :adventures
end