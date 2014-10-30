class DiscountEvent < ActiveRecord::Base
  belongs_to :shop
  has_many :discount_codes
  
  validates :name,:shop_id,:event_type,:presence => true
  
  scope :active, -> { where("(begin_at is null or begin_at < now()  )  and  (end_at is null or end_at > now()  )") }
  
  Types = ["公开","预约"]
  
  def is_public_event?
    self.event_type == "公开"
  end
  
  def is_private_event?
    self.event_type == "预约"
  end
  
  
end