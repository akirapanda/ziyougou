class  Mobile::ShopsController < Mobile::BaseController  
  def index
    @shops = Shop.all
  end
  
  
  def show
    @shop = Shop.find params[:id]
  end
  
end