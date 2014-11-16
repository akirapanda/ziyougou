class Mobile::BaseController < ApplicationController
  
  require 'net/http'
  require 'net/https'
  
  
  layout "mobile"
  APP_ID = "wxa23d51b8ca41d345"
  APP_SEC = "087d57aeb67a8c73ddfb8ab4dd646c60"
  
  before_filter :save_code
  
  
  
  
  def save_code
    if params[:code].present? && params[:state].present?
      query_code(params[:code])
    end
  end
  def query_code(code)
    url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{APP_ID}&secret=#{APP_SEC}&code=#{code}&grant_type=authorization_code"
    puts url
    begin
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true 
      request = Net::HTTP::Get.new(url)
      html_response = http.request(request).body      
      json_resp=JSON.parse(html_response)
      open_id = json_resp["openid"]
      if open_id.present?
        session[:open_id]=open_id
        logger.info("get code #{open_id}  successful")
      else
        logger.info("get code #{json_resp["errcode"]}, #{json_resp["errmsg"]}")
      end
    rescue
      logger.error("get code #{code} failed")
    end   
    
  end
end

