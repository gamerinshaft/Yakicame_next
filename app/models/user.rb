class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :bio, :image, :account_name

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'Username'
  attr_accessor :login
  attr_accessible :login

  has_many :follows
  has_many :following_users, through: :follows, source: :user
  has_many :inverse_follows, class_name: Follow, foreign_key: :followed_id
  has_many :followed_users, through: :inverse_follows, source: :user

  has_many :tweets, dependent: :destroy
  has_many :favorites
  has_many :favoriting_tweets, through: :favorites, source: :tweet
  mount_uploader :image, ImageUploader
  validates :bio, length: {in: 0..60}
  validates :account_name, length: {in: 1..8}, presence: true, uniqueness: true
  validates :username, presence: true, length: {in: 1..6}
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  # attr_accessible :title, :body

  def followed? user
    Follow.exists?(user_id: user.id, followed_id: self.id)
  end

end
