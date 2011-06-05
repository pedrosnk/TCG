class CardsUsers < ActiveRecord::Migration
  def change
    create_table :cards_users, :id=>false do |t|
      t.references :card, :null => false
      t.references :user, :null => false
    end
  end
end
