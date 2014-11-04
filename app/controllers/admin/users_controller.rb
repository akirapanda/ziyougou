class  Admin::UsersController < Admin::BaseController  
  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true)
    @users_grid = initialize_grid(@users,:per_page => 50)
  end
  
  def show
    @user = User.find(params[:id])
  end

end