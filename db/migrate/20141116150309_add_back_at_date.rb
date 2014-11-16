class AddBackAtDate < ActiveRecord::Migration
  def change
    add_column :discount_codes, :back_at ,:date
  end
end
