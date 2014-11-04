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
    
    create_table :sellers do |t|
      t.string :name
      t.string :logo
      t.string :intro
      t.text :content, :limit => 4294967295
      t.integer :rate
      t.integer :shops_count, :default => 0
      t.timestamps
    end
    
    create_table :shops do |t|
      t.string :nation
      t.string :area
      t.string :name
      t.string :address
      t.string :phone
      t.string :logo
      t.integer :seller_id
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
      t.string :last_ip
      t.timestamps
    end
    
    create_table :discount_events do |t|
      t.integer :shop_id
      t.string :name
      t.string :intro
      t.text :content, :limit => 4294967295
      
      t.string :event_type
      t.date :begin_at
      t.date :end_at
      t.datetime :publish_at
      t.boolean :is_visible,:default=>true
      t.integer :discount_codes_count
      t.string :ticket_image
      t.timestamps
    end
    
    create_table :discount_codes do |t|
      t.integer :discount_event_id
      t.integer :user_id
      t.string :image
      t.string :code
      t.date :begin_at
      t.date :end_at
      t.string :name
      t.string :passport_no
      t.string :gender
      t.datetime :leave_at
      t.string :status
      t.timestamps  
    end
    
    
    
  end
end
