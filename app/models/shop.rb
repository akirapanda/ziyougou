class Shop < ActiveRecord::Base
  has_many :discount_events
end