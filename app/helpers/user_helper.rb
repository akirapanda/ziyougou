module UserHelper
  def user_sign_in(user)
   #remember_token = User.new_remember_token
  #cookies.permanent[:remember_token] = remember_token
   #   cookies[:remember_token] = { value: remember_token }
   #  user.update_attributes(remember_token: User.encrypt(remember_token))
   session[:user_id] = user.id
   self.current_user = user
  end

  def user_signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notes: "请登入"
    end
  end

  def user_sign_out
    self.current_user = nil
    session[:user_id] = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default,:flash => {:notice => "登录成功"})
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end