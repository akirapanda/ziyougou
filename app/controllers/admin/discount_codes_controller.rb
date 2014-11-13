class  Admin::DiscountCodesController < Admin::BaseController  

    def to_cancel
      @discount_code = DiscountCode.find(params[:id]) 
      @discount_code.cancel
      @discount_code.save
      redirect_to [:admin,@discount_code], :notice=>"优惠券申请已被取消" 
    end
    
    def to_active
      @discount_code = DiscountCode.find(params[:id]) 
      @discount_code.active
      @discount_code.save
      redirect_to [:admin,@discount_code], :notice=>"优惠券申请已生效" 
    end
    
    def to_inactive
      @discount_code = DiscountCode.find(params[:id]) 
      @discount_code.inactive
      @discount_code.save
      redirect_to [:admin,@discount_code], :notice=>"优惠券申请已失效" 
    end
    
    def to_confirm
      @discount_code = DiscountCode.find(params[:id]) 
      @discount_code.confirm
      @discount_code.save
      redirect_to [:admin,@discount_code], :notice=>"优惠券申请那个信息已被确认" 
    end
  
    def upload_code
      @discount_code = DiscountCode.find(params[:id]) 
      @discount_code.active
      if @discount_code.update(discount_code_params)
        redirect_to [:admin,@discount_code], :notice=>"激活优惠券成功"
      else
        render 'to_active'
      end
    end
  
  
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
      @discount_event = DiscountCode.new(discount_event_params) 
      if @discount_event.save
        redirect_to discount_events_admin_shop_path(@discount_event.shop),:notice=>"新建优惠券记录成功!"
      else
        render 'new'
      end
    end

    def edit
      @discount_code = DiscountCode.find(params[:id]) 
    end

    def update
      @discount_code = DiscountCode.find(params[:id]) 
      if @discount_code.update(discount_code_params)
        redirect_to [:admin,@discount_code],:notice=>"更新优惠券记录成功"
      else
        render 'edit'
      end
    end

    def destroy
      store_last_location
      @discount_event = DiscountCode.find(params[:id]) 
      @discount_event.destroy
      redirect_to last_location(admin_discount_code_path),:notice=>"删除优惠券代码成功!"      
    end

    private
    def discount_code_params
      params.require(:discount_code).permit!
    end
end