class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.references :petition
      t.string :name
      t.string :email
      t.string :zip
      t.text :custom_text

      t.timestamps
    end
    add_index :signatures, :petition_id
  end
end
