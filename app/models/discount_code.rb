class DiscountCode < ActiveRecord::Base
  include AASM
  
  mount_uploader :image, TicketUploader
  
  before_save :update_status
  
  belongs_to :discount_event
  has_one :shop, :through => :discount_event
  has_one :seller, :through => :shop
  belongs_to :user
  validates :name,:mobile ,:out_fly_no , :in_fly_no ,:presence => true
  
  STATUS = ["新申请", "处理中", "已生效", "已失效", "已取消"]
  
  aasm do
     state :new, :initial => true
     state :confirmed
     state :actived
     state :inactived
     state :canceled
     
     event :confirm do
       transitions :from => :new, 
                    :to => :confirmed,:on_transition => :confirm_code
     end
     
     event :active do
       transitions :from => [:new,:confirmed], 
                    :to => :actived,:on_transition => :active_code
     end
     
     event :inactive do
       transitions :from => [:new,:confirmed,:actived,:inactived] ,
                    :to => :inactived,:on_transition => :inactive_code
     end
     
     
     event :cancel do
       transitions :from => [:new,:confirmed,:actived,:inactived], 
                   :to => :canceled,:on_transition => :cancel_code
     end
   end
   
   
   def confirm_code
     
   end
   
   def active_code
     
   end
   
   def inactive_code
     
   end
   
   def cancel_code
     
   end
   
   
   def update_status
     if self.aasm_state == "new"
       self.status = "新申请"
     elsif self.aasm_state == "confirmed"
       self.status = "处理中"
     elsif self.aasm_state == "actived"
       self.status = "已生效"
     elsif self.aasm_state == "inactived"
       self.status = "已失效"
     elsif self.aasm_state == "canceled"
       self.status = "已取消"
     end
   end
   
end