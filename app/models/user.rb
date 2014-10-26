require 'digest/md5' 

class User < ActiveRecord::Base
  validates :phone,:password,:presence => true
  validates :phone, uniqueness: true
  
  OK_STATUS = "正常"
  BLOCK_STATUS = "停用"
  STATUS = ["正常","停用"]
  
  def encrypt_password
     Digest::MD5.hexdigest("#{self.username}#{self.password}")
  end
  
  
  def authenticate(password)
    try_password = Digest::MD5.hexdigest("#{self.username}#{password}")
    
    puts "#{self.password} & #{try_password}"
    try_password == self.password   
  end
end