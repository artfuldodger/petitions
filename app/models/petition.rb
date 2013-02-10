class Petition < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, presence: true
  attr_accessible :description, :title, :type
end
