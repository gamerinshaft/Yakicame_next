class Tweet < ActiveRecord::Base
  attr_accessible :content, :user_id, :image
  belongs_to :user
  mount_uploader :image, ImageUploader
end
