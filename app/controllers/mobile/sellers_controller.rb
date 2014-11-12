class  Mobile::SellersController < Mobile::BaseController
  def index
    @q = Seller.search(params[:q])
    @sellers = @q.result(distinct: true)
  end
  
  
  def show
    @seller = Seller.find(params[:id])
    @shops = @seller.shops
  end
  
end