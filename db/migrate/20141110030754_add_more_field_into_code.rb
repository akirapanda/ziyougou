class AddMoreFieldIntoCode < ActiveRecord::Migration
  def change
    add_column :discount_codes, :hk_passport_no, :string
    add_column :discount_codes, :tw_passport_no, :string
    add_column :discount_codes, :out_fly_no, :string
    add_column :discount_codes, :in_fly_no, :string
  end
end
