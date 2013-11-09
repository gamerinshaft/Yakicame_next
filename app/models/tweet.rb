class Tweet < ActiveRecord::Base
  attr_accessible :content, :image
  default_scope order('created_at DESC').includes(:favorites)
  belongs_to :user
  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
  validates_associated :user
  validates :content, presence: true, length: {in: 1..140}
  def favorited? user
    favorites.any? do |f|
      f.user == user
    end
  end 
end
