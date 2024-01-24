# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  Admin.create!(
    email: 'admin@example.com',
    password: '123456'
  )

  Genre.create!(
    [
      {
        name: 'ケーキ',
      },
      {
        name: '焼き菓子',
      },
      {
        name: 'プリン',
      },
      {
        name: 'キャンディ',
      }
    ]
  )

  3.times do |n|
    Customer.create!(
      email: "test#{n + 1}@test.com",
      last_name: "会員#{n + 1}",
      first_name: "情報#{n + 1}",
      last_name_kana: "カイイン",
      first_name_kana: "ジョウホウ",
      postal_code: "1111111",
      password: "a12345#{n + 1}",
      address: "会員住所#{n + 1}",
      telphone_number: "012000000#{n + 1}",
      is_active: true
    )
  end

 Delivery.create!(
   customer_id: 1,
   attention: "山田 太郎",
   postal_code: "1234567",
   address: "東京都千代田区霞が関1-1-1",
 )

 Delivery.create!(
   customer_id: 2,
   attention: "佐藤 花子",
   postal_code: "2345678",
   address: "神奈川県横浜市港北区新横浜1-1-1",
 )