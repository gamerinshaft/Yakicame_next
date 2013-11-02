class Tweet < ActiveRecord::Base
  attr_accessible :content, :image
  default_scope order('created_at DESC')
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates_associated :user
  validates :content, presence: true, length: {in: 1..140}
end
