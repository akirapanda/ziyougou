class Mobile::SessionsController < Mobile::BaseController
  layout 'mobile_login'
  def new
    if user_signed_in?
      redirect_to [:mobile,current_user]
    end
  end

  def create
    if User.authenticate(params[:session][:mobile],params[:session][:password])
      user = User.find_by_mobile(params[:session][:mobile])
      user_sign_in user
      redirect_back_or mobile_user_path(user)
    else
      flash.now[:error] = "密码错误"
      render 'new'
    end
  end

  def destroy
    user_sign_out
    redirect_to mobile_root_path
  end
end