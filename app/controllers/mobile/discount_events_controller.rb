class  Mobile::DiscountEventsController < Mobile::BaseController  
  before_filter :signed_in_user,:only=>[:apply]
  def show
    @event = DiscountEvent.find(params[:id])
  end
  
  
  def download
    @event = DiscountEvent.find(params[:id])

  end
  
  def apply
   @event = DiscountEvent.find(params[:id])
   
   if @event.is_private_event?
     redirect_to new_mobile_discount_code_path(:event_id=>@event)
   else
     @user = current_user
     @code = @user.discount_codes.find_by(:discount_event_id => @event.id)
     
     if @code 
       #重复声请
       redirect_to [:mobile,@event]
       return
     end
     
     @code = DiscountCode.new
     @code.user =  current_user
     @code.discount_event  = @event
     @code.active
     @code.save(validate: false)
     redirect_to passport_mobile_user_path(current_user)
   end
  end
  

end