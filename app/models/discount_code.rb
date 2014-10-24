class DiscountCode < ActiveRecord::Base
  belongs_to :discount_event
  has_one :shop, :through => :discount_event
  
  belongs_to :user
end