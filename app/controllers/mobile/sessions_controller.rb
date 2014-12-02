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
      
      if session[:open_id]
        exist_users = User.where("open_id = ? and id != ?" ,session[:open_id] ,user.id)
        exist_users.update_all("open_id = null")
        user.update_attribute(:open_id,session[:open_id])
      end
      
      
      redirect_back_or mobile_user_path(user)
    else
      flash.now[:error] = "密码错误"
      render 'new'
    end
  end


  def lost_password
    
  end
  
  
  def send_password
    user = User.find_by(:mobile=>params[:session][:mobile],:email=>params[:session][:email])
    unless user
      flash[:error]="用户信息错误"
      render 'lost_password'
      return 
    end
    
    PasswordMailer.send_reset_token(user).deliver
  end
  
  def reset_password
    token = params[:token]
    @user  =  User.find_by(:reset_token=>token)
    if @user.nil?
      render :text=>"链接无效"
    end
  end
  
  def change_password
    token = params[:user][:reset_token]
    @user  =  User.find_by(:reset_token=>token)
    @user.new_password = params[:user][:new_password]
    @user.new_password_confirmation = params[:user][:new_password_confirmation]
    @user.password = @user.new_password
    if @user.new_password.size < 6
      @user.errors[:new_password] =  "密码长度不正确，应该在6到16位之间"
      render 'reset_password'
      return
    end
    
    if @user.save
      @user.reset_token = nil
      @user.reset_token_at = nil
      @user.save
    else
      render 'reset_password'
    end
  end
  
  def destroy
    user_sign_out
    redirect_to mobile_root_path
  end
  
  private    
  def user_params
    params.require(:user).permit!
  end
  
  
end