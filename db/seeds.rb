# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザーデータ=============================================================
user = [
  {
    id: 1,
    name: '採用ご担当者様',
    email: 'recruit@example.com',
    password: 'password',
    introduction: 'ご覧頂き、誠にありがとうございます。ご査収の程、よろしくお願い致します。',
    confirmed_at: '2020-07-01 03:37:42.086451'
  },
  {
    id: 2,
    name: 'Taro',
    email: 'Taro@example.com',
    password: 'password',
    introduction: 'Taroです。プログラミングとギターが大好きです。',
    confirmed_at: '2020-07-26 03:37:42.086451'
  },
  {
    id: 3,
    name: 'ごんしば',
    email: 'gonshiba@example.com',
    password: 'gonshiba',
    introduction: 'ごんしばです。バックエンドエンジニアとして高速で成長して参ります',
    confirmed_at: '2020-07-26 03:37:42.086451'
  }
]
user.each do |record|
  User.create!(record) unless User.find_by(email: record[:email])
end

# フォロー=============================================================
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user3.follow(user1)
user1.follow(user3)


# コンテンツデータ=============================================================
(1..5).each do |no|
  Content.create!(
    {
      name: "Title#{no}",
      url: 'https://mybook-gn.herokuapp.com',
      description: "#{no}のサイト",
      category: 'Webサイト',
      private: 1,
      user_id: 1
    }
  )
end
(1..5).each do |no|
  Content.create!(
    {
      name: "Taroの勉強用サイトDEMO#{no}",
      url: 'https://mybook-gn.herokuapp.com',
      description: "Taroの勉強用サイトDEMO#{no}",
      category: 'Webサイト',
      private: 1,
      user_id: 3
    }
  )
end

Content.create!(
  [
    {
      id: 1,
      name: 'まいぶく',
      url: 'https://mybook-gn.herokuapp.com',
      description: 'ブックマーク管理アプリ',
      category: 'Webアプリ',
      private: 1,
      user_id: 1
    },
    {
      id: 2,
      name: 'Twitter',
      url: 'https://twitter.com/GonshibaN',
      description: '主に日々の学習を呟いています',
      category: 'SNS',
      private: 2,
      user_id: 3
    },
    {
      id: 3,
      name: 'wantedly',
      url: 'https://www.wantedly.com/users/136511116',
      description: 'wantedlyプロフィールページです',
      category: 'SNS',
      private: 2,
      user_id: 3
    },
    {
      id: 4,
      name: 'GitHub',
      url: 'https://github.com/gonshiba-n/Rails-My_Book_App',
      description: 'まいぶくを管理しているGitHubページです',
      category: 'プログラミング',
      private: 2,
      user_id: 3
    },
    {
      name: 'Ruby参考書',
      url: 'https://www.amazon.co.jp/%E3%83%97%E3%83%AD%E3%82%92%E7%9B%AE%E6%8C%87%E3%81%99%E4%BA%BA%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AERuby%E5%85%A5%E9%96%80-%E8%A8%80%E8%AA%9E%E4%BB%95%E6%A7%98%E3%81%8B%E3%82%89%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA%E3%83%BB%E3%83%87%E3%83%90%E3%83%83%E3%82%B0%E6%8A%80%E6%B3%95%E3%81%BE%E3%81%A7-Software-Design-plus%E3%82%B7%E3%83%AA%E3%83%BC%E3%82%BA/dp/4774193976/ref=sr_1_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=Ruby&qid=1595697690&sr=8-1',
      description: 'プロを目指す人のためのRuby入門。RUbyの基礎部分を学びました。',
      category: 'プログラミング',
      private: 2,
      user_id: 3
    },
    {
      name: 'Ruby on Rails参考書',
      url: 'https://www.amazon.co.jp/%E7%8F%BE%E5%A0%B4%E3%81%A7%E4%BD%BF%E3%81%88%E3%82%8B-Ruby-Rails-5%E9%80%9F%E7%BF%92%E5%AE%9F%E8%B7%B5%E3%82%AC%E3%82%A4%E3%83%89-%E5%A4%A7%E5%A0%B4%E5%AF%A7%E5%AD%90/dp/4839962227/ref=sr_1_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=Rails&qid=1595697856&sr=8-1',
      description: '現場で使える Ruby on Rails 5速習実践ガイド。この参考書が私のRailsのベースを作りました',
      category: 'プログラミング',
      private: 2,
      user_id: 3
    },
    {
      name: 'Web参考書',
      url: 'https://www.amazon.co.jp/%E3%82%A4%E3%83%A9%E3%82%B9%E3%83%88%E5%9B%B3%E8%A7%A3%E5%BC%8F-%E3%81%93%E3%81%AE%E4%B8%80%E5%86%8A%E3%81%A7%E5%85%A8%E9%83%A8%E3%82%8F%E3%81%8B%E3%82%8BWeb%E6%8A%80%E8%A1%93%E3%81%AE%E5%9F%BA%E6%9C%AC-%E5%B0%8F%E6%9E%97-%E6%81%AD%E5%B9%B3-ebook/dp/B06XNMMC9S/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=Web&qid=1595697957&sr=8-2',
      description: 'この一冊で全部わかるWeb技術の基本。最も理解がしやすい本を手に取りました',
      category: 'プログラミング',
      private: 2,
      user_id: 3
    },
    {
      name: 'Web参考書2',
      url: 'https://www.amazon.co.jp/Web%E3%82%92%E6%94%AF%E3%81%88%E3%82%8B%E6%8A%80%E8%A1%93-HTTP%E3%80%81URI%E3%80%81HTML%E3%80%81%E3%81%9D%E3%81%97%E3%81%A6REST-WEB-PRESS-plus/dp/4774142042/ref=sr_1_3?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=Web&qid=1595697957&sr=8-3',
      description: 'Webを支える技術 -HTTP、URI、HTML、そしてREST。現在はこの参考書を読み進めています。',
      category: 'プログラミング',
      private: 2,
      user_id: 3
    }
  ]
)

content1 = Content.find(1)
content2 = Content.find(2)
content3 = Content.find(3)
content4 = Content.find(4)

# コメント=============================================================
content1.comments.create(user_id: user3.id, comment: "初めての自作アプリです！")
content4.comments.create(user_id: user3.id, comment: "Gitは奥が深いのでしっかりと学習します")