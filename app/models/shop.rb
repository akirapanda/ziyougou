class Shop < ActiveRecord::Base
  
  belongs_to :seller, counter_cache: true
  belongs_to :nation
  has_many :discount_events
  mount_uploader :logo, ShopLogoUploader
  
  validates :name,:presence => true
  
end