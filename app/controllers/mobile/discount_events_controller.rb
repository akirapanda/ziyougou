class  Mobile::DiscountEventsController < Mobile::BaseController  
  before_filter :signed_in_user,:only=>[:apply]
  def show
    @event = DiscountEvent.find(params[:id])
  end
  
  
  def download
    @event = DiscountEvent.find(params[:id])
    send_file("#{Rails.root}/public#{@event.ticket_image_url}",
              filename: "#{@event.id}.jpg")
    
  end
  
  def apply
   @event = DiscountEvent.find(params[:id])
   
   if @event.is_private_event?
     redirect_to new_mobile_discount_code_path(:event_id=>@event)
   end
   
   
  end
  

end