class User < ActiveRecord::Base
  has_and_belongs_to_many :cards
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_presence_of :login
  validates_uniqueness_of :login

  # Setup accessible (or protected) attributes for your model
  attr_accessor :credential
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :credential
  
  def is_admin?
    read_attribute(:admin)
  end
  
  def has_card test_card
    cards.each{|card| return true if card.id == test_card.id}
    return false
  end
  
  def cards_of_expansion expansion
    r = []
    cards.each{|card| r << card if card.expansion.id == expansion.id}
    r
  end
  
  def cards_of_expansion_and_rarity expansion, rarity
    r = []
    cards_of_expansion(expansion).each{|card| r << card if card.rarity == rarity}
    r
  end
  
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    credential = conditions.delete(:credential)
    where(conditions).where(["lower(login) = :value OR lower(email) = :value", { :value => credential.downcase }]).first
  end
  
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end 

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:credential)
         credential = attributes.delete(:credential)
         record = find_record(credential)
      else  
        record = where(attributes).first
      end  
    end  

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end  
    end  
    record
  end

  def self.find_record(credential)
    where(["login = :value OR email = :value", { :value => credential }]).first
  end
end
