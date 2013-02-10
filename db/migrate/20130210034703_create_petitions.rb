class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.references :user
      t.string :title
      t.text :description
      t.string :type

      t.timestamps
    end
    add_index :petitions, :user_id
  end
end
