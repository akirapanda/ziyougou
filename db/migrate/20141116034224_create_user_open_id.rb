class CreateUserOpenId < ActiveRecord::Migration
  def change
    create_table :user_open_ids do |t|
      add_column :users ,:open_id ,:string
    end
  end
end
