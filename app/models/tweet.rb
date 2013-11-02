class Tweet < ActiveRecord::Base
  attr_accessible :content, :image
  belongs_to :user
  mount_uploader :image, ImageUploader
end
