class  Admin::AdminUsersController < Admin::BaseController  
  def index
    @q = AdminUser.search(params[:q])
    @admin_users = @q.result(distinct: true)
    @admin_users_grid = initialize_grid(@admin_users,:per_page => 50)
  end
  
  def show
    @user = AdminUser.find(params[:id])
  end
  
  def new
    @admin_user = AdminUser.new
  end
  
  def edit
    @admin_user = AdminUser.find(params[:id])
  end
  
  def edit_password
    @admin_user = AdminUser.find(params[:id])
  end
  
  def create
    @admin_user = AdminUser.new(admin_user_params) 
    if @admin_user.save
      redirect_to admin_admin_users_path,:notice=>"新建系统管理员成功"
    else
      render 'new'
    end  
  end
  
  def update
    @admin_user = AdminUser.find(params[:id]) 
    if @admin_user.update(admin_user_params)
      redirect_to admin_admin_users_path,:notice=>"更新系统管理员成功"
    else
      render 'edit'
    end
  end

  def update_password
    @admin_user = AdminUser.find(params[:id]) 
    if @admin_user.update(admin_user_params)
      redirect_to admin_admin_users_path,:notice=>"变更密码操作成功"
    else
      render 'edit_password'
    end
  end
  
  def destroy
    @admin_user = AdminUser.find(params[:id])
    @admin_user.destroy
    redirect_to admin_admin_users_path,:notice=>"删除系统管理记录成功"
  end
  
  private
  def admin_user_params
    params.require(:admin_user).permit(:email,:password,:password_confirmation)
  end
end