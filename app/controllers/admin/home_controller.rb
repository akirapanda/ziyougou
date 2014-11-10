class  Admin::HomeController < Admin::BaseController  
  def index
    @new = DiscountCode.where(:status => "新申请").size
    @process = DiscountCode.where(:status => "处理中").size
    @completed = DiscountCode.where(:status => "已生效").size
    @canceled = DiscountCode.where(:status => "已取消").size
    
    
  end
end