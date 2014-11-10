class  Mobile::DiscountCodesController < Mobile::BaseController  
  
  def show
    @code = DiscountCode.find(params[:id])
    @event = @code.discount_event 
  end
  
  def detail
    @code = DiscountCode.find(params[:id])
  end
  
  
  def new
    @code  = DiscountCode.new
    if params[:event_id].present?
      @code.discount_event_id = params[:event_id]
    end
  end
  
  
  def create
    @code = DiscountCode.new(discount_code_params) 
    @code.user_id = current_user.id
    if @code.save
      redirect_to [:mobile,@code.discount_event],:notice => "新建品牌成功!"
    else
      render 'new'
    end
  end
  
  
  def edit
    @code = DiscountCode.find(params[:id])
  end
  
  def update
    @code = DiscountCode.find(params[:id])
    if @code.update(discount_code_params)
      redirect_to detail_mobile_discount_code_path(@code),:notice=>"更新优惠券记录成功"
    else
      render 'edit'
    end
   end
  
  
  private
  def discount_code_params
    params.require(:discount_code).permit!
  end
end