class  Admin::DiscountCodesController < Admin::BaseController  
  
    def index
      @q = DiscountCode.search(params[:q])
      @discount_codes = @q.result(distinct: true)
      @discount_codes_grid = initialize_grid(@discount_codes,:per_page => 50)
    end
    
    def show
      @discount_code = DiscountCode.find(params[:id]) 
    end
    
    def new
      @discount_code = DiscountCode.new
    end

    def create
      @discount_event = DiscountEvent.new(discount_event_params) 
      if @discount_event.save
        redirect_to discount_events_admin_shop_path(@discount_event.shop),:notice=>"新建商户优惠活动成功!"
      else
        render 'new'
      end
    end

    def edit
      @discount_event = DiscountEvent.find(params[:id]) 
    end

    def update
      @discount_event = DiscountEvent.find(params[:id]) 
      if @discount_event.update(discount_event_params)
        redirect_to discount_events_admin_shop_path(@discount_event.shop),:notice=>"更新商户优惠活动成功"
      else
        render 'edit'
      end
    end

    def destroy
      @discount_event = DiscountEvent.find(params[:id]) 
      @discount_event.destroy
      redirect_to discount_events_admin_shop_path(@discount_event.shop),:notice=>"删除商户优惠活动成功"
    end

    private
    def discount_event_params
      params.require(:discount_event).permit!
    end
end