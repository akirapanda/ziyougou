class  Admin::NationsController < Admin::BaseController  
  
  def index
    @q = Nation.search(params[:q])
    @nations = @q.result(distinct: true)
    @nations_grid = initialize_grid(@nations,:per_page => 50)
  end
  
  def show
    @nation = Nation.find(params[:id])
    
  end
  
  def new
    @nation = Nation.new
  end
  
  def edit
    @nation = Nation.find(params[:id])
  end
  
  def create
    @nation = Nation.new(nation_params) 
    if @nation.save
      redirect_to admin_nations_path,:notice=>"新增记录成功"
    else
      render 'new'
    end
  end
  
  
  def update
    @nation = Nation.find(params[:id])
    if @nation.update(nation_params)
      redirect_to admin_nations_path,:notice=>"更新记录成功"
    else
      render 'edit'
    end
  end
  
  def destroy
    store_last_location
    @nation = Nation.find(params[:id])
    @nation.destroy
    redirect_to last_location(admin_nations_path),:notice=>"删除记录成功!"      
  end
  
  private
  def nation_params
    params.require(:nation).permit!
  end
end