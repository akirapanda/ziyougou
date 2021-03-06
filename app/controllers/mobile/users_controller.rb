class  Mobile::UsersController < Mobile::BaseController  
  layout 'mobile_login', only: [:new, :forgot_password, :password_reset]          
  
  def passport
    @user = User.find(params[:id])
    @codes = @user.discount_codes 
    render layout: "mobile"
  end      
         
  def show
    @user = User.find(params[:id])
    render layout: "mobile"
  end
   
  def new
     if user_signed_in?
       redirect_to [:mobile,current_user]
     else
       @user = User.new
     end
   end
   
   
  def create
    @user = User.new(user_params)
    @checked=false
    unless params[:agree_box].present?
      @user.errors.add("请确认用户协议", "")
      render 'new',layout: "mobile_login"
      return
    end
    @checked = true
    
    @user.password = @user.new_password
    if @user.save
      user_sign_in @user
      @user.update_attribute(:last_ip, request.remote_ip)
      redirect_to mobile_root_path, :flash => { :notice=> "欢迎登陆自由购物帮" }
    else
      render 'new',layout: "mobile_login"
    end   
  end
  
  private    
  def user_params
    params.require(:user).permit!
  end
    
end