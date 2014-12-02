class PasswordMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  
  default from: "rd@newnil.com"
  require 'digest/md5' 
  
  def send_reset_token(user)
    time = Time.now
    @token = Digest::MD5.hexdigest("#{time}#{user.email}")
    @title = "[自游购物帮]密码重置邮件"
    mail to: user.email, subject: "[自游购物帮]密码重置邮件"
    
    user.reset_token = @token
    user.reset_token_at = time
    user.save
  end
end