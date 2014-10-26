class  Mobile::UsersController < Mobile::BaseController  
  layout 'mobile_login',:only=>[:new]
  def new
     @user = User.new
   end
end