class AddNations < ActiveRecord::Migration
  def change
    create_table :nations do |t|
      t.string :name
      t.string :flag_filename
      t.timestamps
    end
    add_column :sellers ,:nation_id,:integer
    add_column :shops ,:nation_id,:integer
    remove_column :shops ,:nation
    
  end
end
