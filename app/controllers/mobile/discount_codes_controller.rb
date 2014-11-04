class  Mobile::DiscountCodesController < Mobile::BaseController  
  

  
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
  
  private
  def discount_code_params
    params.require(:discount_code).permit!
  end
end