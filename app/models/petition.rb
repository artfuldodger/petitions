class Petition < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, presence: true
  attr_accessible :description, :title, :type, :deleted_at

  default_scope { where(deleted_at: nil) }

  def self.deleted
    with_exclusive_scope { where('deleted_at is not null') }
  end
end
