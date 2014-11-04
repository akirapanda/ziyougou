class  Admin::SellersController < Admin::BaseController  
  def index
    @q = Seller.search(params[:q])
    @sellers = @q.result(distinct: true)
    @sellers_grid = initialize_grid(@sellers,:per_page => 20)
  end
  
  
  def shops
    @seller = Seller.find(params[:id])
    @shops = @seller.shops
    @shops_grid = initialize_grid(@shops,:per_page => 20)
    
  end
  
  def show
    @seller = Seller.find(params[:id])
  end
  
  
  def new
    @seller = Seller.new
  end
  
  def edit
    @seller = Seller.find(params[:id])
  end
  
  def create
    @seller = Seller.new(seller_params) 
    if @seller.save
      redirect_to [:admin,@seller],:notice => "新建品牌成功!"
    else
      render 'new'
    end
  end
  
  def update
    @seller = Seller.find(params[:id])
    if @seller.update(seller_params)
      redirect_to [:admin,@seller],:notice => "编辑品牌成功!"
    else
      render 'edit'
    end
  end
  
  private
  def seller_params
    params.require(:seller).permit!
  end
end