class Seller < ActiveRecord::Base
  has_many :shops
  mount_uploader :logo, ShopLogoUploader
  validates :name,:presence => true
  validates :name, uniqueness: true
  
end