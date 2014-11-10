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
  
  
  def destroy
    @seller = Seller.find(params[:id])
    
   if @seller.shops.empty?
     @seller.destroy
     if back_path.include?("sellers/")
       redirect_to admin_sellers_path ,:notice=>"删除品牌成功"
     else
       redirect_to back_path ,:notice=>"删除品牌成功"
     end
   else
     redirect_to back_path ,:alert=>"该品牌下还有门店信息,不可删除"
   end
  end
  
  private
  def seller_params
    params.require(:seller).permit!
  end
end