class Card < ActiveRecord::Base
  belongs_to :expansion
  has_and_belongs_to_many :users
  
  validates_presence_of :expansion_order, :name, :rarity, :card_type
  validates_uniqueness_of :expansion_order, :scope => :expansion_id
  
  validates_inclusion_of :rarity, :in => [:common,:uncommon,:rare,:rare_holo,:rare_holo_lv_x]
  validates_inclusion_of :card_type, :in => [:trainer,:water,:grass,:psychic,:lightning,:darkness,:metal,:fire,:fighting,:colorless,:supporter,:stadium,:energy,:special_energy]

   def rarity
     value = read_attribute(:rarity)
     value.nil? ? nil : value.to_sym
   end

   def rarity= (value)
     write_attribute(:rarity, value.to_s)
   end
   
   def card_type
     value = read_attribute(:card_type)
     value.nil? ? nil : value.to_sym
   end

   def card_type= (value)
     write_attribute(:card_type, value.to_s)
   end
end
