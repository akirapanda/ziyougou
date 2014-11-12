class RecommendEvent < ActiveRecord::Base
  validates :title,:presence => true
  mount_uploader :cover, TicketUploader
  
end