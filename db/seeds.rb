# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@babaiban = Seller.create(:name=>"八佰伴")
@laiyifen = Seller.create(:name=>"来一份")


@shop = Shop.create(nation: '日本', area: "东京", name: "八佰伴东京店",:address=>"东京市池袋区123号",:phone=>"1234567",:seller_id=>@babaiban.id)
Shop.create(nation: '日本', area: "东京", name: "八佰伴大阪店",:address=>"大阪市八王子区123号",:phone=>"7654321",:seller_id=>@babaiban.id)
Shop.create(nation: '日本', area: "东京", name: "来一份东京店",:address=>"东京市东海区123号",:phone=>"2222222",:seller_id=>@laiyifen.id)

DiscountEvent.create(shop_id: @shop.id, name: "测试公开活动",:event_type=>"公开",:intro=>"测试的介绍文本")
