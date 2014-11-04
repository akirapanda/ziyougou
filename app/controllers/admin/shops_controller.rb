class  Admin::ShopsController < Admin::BaseController  
    def discount_events
      @shop = Shop.find(params[:id]) 
      @discount_events_grid = initialize_grid(@shop.discount_events,:per_page => 10)
    end
  
    def index
      @q = Shop.search(params[:q])
      @shops = @q.result(distinct: true)
      @shops_grid = initialize_grid(@shops,:per_page => 50)
    end
    
    def show
      @shop = Shop.find(params[:id]) 
    end
    
    def new
      @shop = Shop.new
      if params[:seller_id].present?
        @shop.seller_id = params[:seller_id]
      end
    end

    def create
      @shop = Shop.new(shop_params) 
      if @shop.save
        redirect_to [:admin,@shop],:notice=>"新建商户成功!"
      else
        render 'new'
      end
    end

    def edit
      @shop = Shop.find(params[:id]) 
    end

    def update
      @shop = Shop.find(params[:id]) 
      if @shop.update(shop_params)
        redirect_to [:admin,@shop],:notice=>"更新商户成功"
      else
        render 'edit'
      end
    end

    def destroy
      @shop = Shop.find(params[:id]) 
      @shop.destroy
      redirect_to admin_shops_path
    end

    private
    def shop_params
      params.require(:shop).permit!
    end
end