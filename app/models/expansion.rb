class Expansion < ActiveRecord::Base
  validates :name, :presence => true
  has_many :cards, :dependent => :destroy
  
  def cards_by_rarity rarity
    r = []
    cards.each {|card| r << card if card.rarity == rarity}
    r
  end
end
