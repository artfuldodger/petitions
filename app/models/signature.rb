class Signature < ActiveRecord::Base
  belongs_to :petition
  attr_accessible :custom_text, :email, :name, :zip
end
