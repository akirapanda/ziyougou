class DiscountCode < ActiveRecord::Base
  belongs_to :discount_event
  belongs_to :shop,:through => :discount_event
  
  belongs_to :user
end