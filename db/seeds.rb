# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Shop.create(country: '日本', area: "东京", name: "东京八佰伴",:address=>"东京市池袋区123号",:phone=>"1234567")
Shop.create(country: '日本', area: "东京", name: "东京七佰伴",:address=>"东京市八王子区123号",:phone=>"7654321")
Shop.create(country: '日本', area: "东京", name: "东京六佰伴",:address=>"东京市东海区123号",:phone=>"2222222")
