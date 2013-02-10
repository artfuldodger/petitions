class User < ActiveRecord::Base
  has_many :petitions

  validates :username, :display_name, presence: true, uniqueness: true
  attr_accessible :display_name, :password, :username

  has_secure_password
end
