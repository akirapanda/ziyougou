class  Mobile::DiscountCodesController < Mobile::BaseController  
  def new
    @code  = DiscountCode.new
    
  end
end