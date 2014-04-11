# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# RoomType
RoomType.create( id: 1, denomination: "Matrimonial", amount: 200 )
RoomType.create( id: 2, denomination: "Twin", amount: 100 )


#Group
Group.create( id: 1, name: "Combinada 123-124", amount: 150 )
Group.create( id: 2, name: "Combinada 141-142", amount: 150 )
Group.create( id: 3, name: "Combinada 211-212", amount: 150 )
Group.create( id: 4, name: "Combinada 233-234", amount: 150 )


# Room
Room.create( number: 111, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 112, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 113, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 114, amount: 0, active: true, page_id: 1, room_type_id: 2 )

Room.create( number: 121, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 122, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 123, amount: 0, active: true, page_id: 1, room_type_id: 2, group_id: 1 )
Room.create( number: 124, amount: 0, active: true, page_id: 1, room_type_id: 2, group_id: 1 )

Room.create( number: 131, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 132, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 133, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 134, amount: 0, active: true, page_id: 1, room_type_id: 2 )

Room.create( number: 141, amount: 0, active: true, page_id: 1, room_type_id: 2, group_id: 2 )
Room.create( number: 142, amount: 0, active: true, page_id: 1, room_type_id: 1, group_id: 2 )
Room.create( number: 143, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 144, amount: 0, active: true, page_id: 1, room_type_id: 1 )

Room.create( number: 151, amount: 0, active: true, page_id: 1, room_type_id: 1 )
Room.create( number: 152, amount: 0, active: true, page_id: 1, room_type_id: 1 )

Room.create( number: 211, amount: 0, active: true, page_id: 2, room_type_id: 1, group_id: 3 )
Room.create( number: 212, amount: 0, active: true, page_id: 2, room_type_id: 2, group_id: 3 )
Room.create( number: 213, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 214, amount: 0, active: true, page_id: 2, room_type_id: 2 )

Room.create( number: 221, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 222, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 223, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 224, amount: 0, active: true, page_id: 2, room_type_id: 2 )

Room.create( number: 231, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 232, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 233, amount: 0, active: true, page_id: 2, room_type_id: 1, group_id: 4 )
Room.create( number: 234, amount: 0, active: true, page_id: 2, room_type_id: 2, group_id: 4 )

Room.create( number: 241, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 242, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 243, amount: 0, active: true, page_id: 2, room_type_id: 1 )
Room.create( number: 244, amount: 0, active: true, page_id: 2, room_type_id: 2 )

# Page
Page.create( id: 1, name: "Pagina 1" )
Page.create( id: 2, name: "Pagina 2" )

# User
User.create( login: "webmaster", password: "asd", password_confirmation: "asd", email: "webmaster", name: "webmaster", lastname: "webmaster" )
User.create( login: "junzueta", password: "asd", password_confirmation: "asd", email: "mail@completar", name: "Jose", lastname: "Unzueta" )
User.create( login: "aunzueta", password: "asd", password_confirmation: "asd", email: "mail@completar", name: "Agustin", lastname: "Unzueta" )

