class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attr_writer :login

  validate :validate_username
  validate :info
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true


  before_save :set_info

  def set_info
    self.info = "We don't know much about him/her, but we're sure that he/she is great." if self.info.blank?
  end

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where([
         "lower(username) = :value OR lower(email) = :value",
         { value: login.strip.downcase },
       ]).first
  end
      
      #  if login = conditions.delete(:login)
      #    where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      #  elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      #    where(conditions.to_h).first
      #  end
      #end
      
      
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end
