class  Admin::ShopsController < Admin::BaseController  
    def index
      @q = Shop.search(params[:q])
      @shops = @q.result(distinct: true)
      @shops_grid = initialize_grid(@shops,:per_page => 50)
    end
    
end