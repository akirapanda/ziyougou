class Shop < ActiveRecord::Base
  has_many :discount_events
  mount_uploader :logo, ShopLogoUploader
  
  validates :name,:presence => true
  
end