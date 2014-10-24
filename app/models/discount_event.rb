class DiscountEvent < ActiveRecord::Base
  belongs_to :shop
  has_many :discount_codes
  
  validates :name,:shop_id,:event_type,:presence => true
  
  
  Types = ["公开","预约"]
end