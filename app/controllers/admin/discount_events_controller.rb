class  Admin::DiscountEventsController < Admin::BaseController  
  
  
    def discount_codes
      @discount_event = DiscountEvent.find(params[:id]) 
      @discount_codes_grid = initialize_grid(@discount_event.discount_codes,:per_page => 20)
    end
    
    
    def index
      @q = DiscountEvent.search(params[:q])
      @discount_events = @q.result(distinct: true)
      @discount_events_grid = initialize_grid(@discount_events,:per_page => 50)
    end
    
    def show
      @discount_event = DiscountEvent.find(params[:id]) 
    end
    
    def new
      @discount_event = DiscountEvent.new
      if params[:shop_id]
        @discount_event.shop_id = params[:shop_id]
      end
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