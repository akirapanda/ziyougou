class  Mobile::SellersController < Mobile::BaseController
  def index
    @sellers = Seller.all
  end
  
  
  def show
    @seller = Seller.find(params[:id])
    @shops = @seller.shops
  end
  
end