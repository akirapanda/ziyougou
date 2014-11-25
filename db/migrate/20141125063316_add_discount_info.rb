class AddDiscountInfo < ActiveRecord::Migration
  def change
    add_column  :discount_events,:discount_info,:string
  end
end
