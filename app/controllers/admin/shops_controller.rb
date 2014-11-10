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
      
       @seller = Seller.find(params[:id])

      if @seller.shops.empty?
        @seller.destroy
        if back_path.include?("sellers/")
          redirect_to shops_admin_seller_path(@seller) ,:notice=>"删除门店成功"
        else
          redirect_to back_path ,:notice=>"删除门店成功"
        end
      else
        redirect_to back_path ,:alert=>"该门店下还有活动中的优惠活动,不可删除"
      end

      
    end

    private
    def shop_params
      params.require(:shop).permit!
    end
end