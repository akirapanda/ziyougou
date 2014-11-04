module DiscountHelper
  def has_applied(discount_event_id)
    if current_user.nil?
      return false
    end
    
    @exist_code = DiscountCode.where("user_id = ? and discount_event_id = ?", current_user.id, discount_event_id)
    
    if @exist_code.any?
      return true
    else
      return false
    end
  end
  
end