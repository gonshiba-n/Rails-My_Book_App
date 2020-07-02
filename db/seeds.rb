# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



recruiter = [
	{
	id: 1,
	name: '採用ご担当者様',
	email: 'recruit@example.com',
	password: 'password',
	introduction: 'ご覧頂き、誠にありがとうございます。ご査収の程、よろしくお願い致します。',
	confirmed_at: '2020-07-01 03:37:42.086451'
	}
]
recruiter.each do |record|
	User.create!(record) unless User.find_by(email: record[:email])
end

Content.create!(
	{
		name: 'まいぶく',
		url: 'https://mybook-gn.herokuapp.com',
		description: 'ブックマーク管理アプリ',
		category: 'Webアプリ',
		private: 1,
		user_id: 1
	}
)