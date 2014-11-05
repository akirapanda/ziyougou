class AddAasmSupport < ActiveRecord::Migration
  def change
    add_column :discount_codes , :aasm_state ,:string
    add_column :discount_codes , :canceled_at ,:datetime
  end
end
