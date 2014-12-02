class AddResetToken < ActiveRecord::Migration
  def change
    add_column  :users,:reset_token,:string
    add_column  :users,:reset_token_at,:datetime
  end
end
