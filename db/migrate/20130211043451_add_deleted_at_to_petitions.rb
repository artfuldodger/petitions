class AddDeletedAtToPetitions < ActiveRecord::Migration
  def change
    add_column :petitions, :deleted_at, :datetime
  end
end
