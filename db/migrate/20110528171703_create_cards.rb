class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :expansion_order
      t.string :name
      t.string :rarity
      t.string :card_type
      t.references :expansion

      t.timestamps
    end
    add_index :cards, :expansion_id
  end
end
