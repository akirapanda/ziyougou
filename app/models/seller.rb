class Seller < ActiveRecord::Base
  has_many :shops
  has_many :discount_events, :through=>:shops
  
  mount_uploader :logo, ShopLogoUploader
  validates :name,:presence => true
  validates :name, uniqueness: true
  belongs_to :nation
  
  def last_discount_event
    self.discount_events.order("created_at desc").first
  end
end