class CreateWeixin < ActiveRecord::Migration
  def change
    create_table :wx_users do |t|
      t.string :open_id
      t.string :nickname
      t.string :area
      t.string :gender
      t.string :status
      t.datetime :last_msg_at
      t.timestamps
    end
    
    create_table :trip_guides do |t|
      t.string :title
      t.string :cover
      t.string :place_name
      t.string :brief
      t.string :author
      t.text :content, :limit => 4294967295
      t.boolean :is_recommend
      t.timestamps
    end
    
    create_table :recommend_events do |t|
      t.string :title
      t.string :cover
      t.string :brief
      t.text :content, :limit => 4294967295
      t.boolean :is_recommend
      t.timestamps
    end
    
    create_table :shops do |t|
      t.string :nation
      t.string :area
      t.string :name
      t.string :address
      t.string :phone
      t.string :logo
      t.text :content, :limit => 4294967295
      t.timestamps
    end
    
    create_table :users do |t|
      t.string :email
      t.string :mobile
      t.string :password
      t.string :salt
      t.integer :point
      t.decimal :balance_amount
      
      t.string :name
      t.string :passport_no
      t.string :gender
      t.string :status
      t.timestamp
    end
    
    create_table :discount_events do |t|
      t.string :name
      t.string :event_type
      t.datetime :begin_at
      t.datetime :end_at
      t.datetime :publish_at
      t.boolean :is_visible,:default=>true
      t.integer :discount_codes_count
      t.timestamps
    end
    
    create_table :discount_codes do |t|
      t.integer :discount_event_id
      t.integer :user_id
      t.string :image
      t.string :code
      t.datetime :begin_at
      t.datetime :end_at
      t.string :name
      t.string :passport_no
      t.string :gender
      t.datetime :leave_at
      t.string :status
    end
    
    
    
  end
end
