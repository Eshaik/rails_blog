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

  has_many :active_follows, class_name:  "Follow",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
                            
  has_many :passive_follows, class_name:  "Follow",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy

  has_many :following, through: :active_follows, source: :followed, class_name: 'User'
  has_many :followers, through: :passive_follows, source: :follower, class_name: 'User'


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
  
  # Follows a user.
   def follow(other_user)
    active_follows.create(followed_id: other_user.id)
  end
  
  # Unfollows a user.
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

   # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end
