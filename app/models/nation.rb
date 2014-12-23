class Nation < ActiveRecord::Base
  mount_uploader :flag_filename, FlagUploader
  has_many :sellers,:dependent=>:nullify
  
  
  validates :name,:presence => true
  validates :name, uniqueness: true
  
  
  def flag_image
    self.flag_filename_url
  end
end