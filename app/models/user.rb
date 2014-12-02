require 'digest/md5' 

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :new_password
  
  validates :mobile, uniqueness: true
  validates :mobile,:password,:presence => true
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}
  validates :new_password, confirmation: true
  validates_length_of :new_password, :within => 6..16, message: '密码长度不正确，应该在6到16位之间', on: :create
  validates :mobile,length: { is: 11 }
  validates :mobile, format: { with: /\A\+?[\d]*-?[\d]*\z/, message: ' 电话只能输入数字'}
  has_many :discount_codes
  
  
  OK_STATUS = "正常"
  BLOCK_STATUS = "停用"
  STATUS = ["正常","停用"]
  
  def User.authenticate(mobile,password)
    if user = find_by_mobile(mobile)
      if user.password == encrypt_password(password,user.salt)
        user
      end
    end
  end
  
  def User.encrypt_password(password,salt)
    Digest::SHA2.hexdigest(password+"ziyougou"+salt)
  end
  
  def generate_salt
    self.salt=self.object_id.to_s+rand.to_s
  end
  
  def password= (new_password)
    if new_password.present?
      generate_salt
      write_attribute :password , self.class.encrypt_password(new_password,salt)
    end
  end
end