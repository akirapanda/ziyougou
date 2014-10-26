module ApplicationHelper
  
  def active_side_link(target)
		if ( controller_name && target.index(controller_name) )
      "active" 
    else
      ""
    end
  end
  
  
  def active_menu(target)
    if ( controller_name && target.index(controller_name) )
      "in" 
    else
      ""
    end
  end
end
