class Nation < ActiveRecord::Base
  def flag_image
    "/images/flag/#{flag_filename}"
  end
end