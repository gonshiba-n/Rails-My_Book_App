# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



users = [
		{name: '採用ご担当者様',
			email: 'recruit@example.com',
			password: 'password',
			introduction: 'ご覧頂き、誠にありがとうございます。ご査収の程、よろしくお願い致します。'}
	]
users.each do |record|
  User.create!(record) unless User.find_by(email: record[:email])
end