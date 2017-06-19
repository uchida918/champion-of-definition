# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: "admin", email: "admin@test.com", password: "password", admin: true)
puts ". -> admin_user_complete"
29.times do |n|
  User.create!(username: Faker::Name.name,
               email: "test#{n}@test.com",
               password: "password")
  print "."
end
puts " -> test_user_complete"

areas = ['憲法', '民法', '刑法', '商法', '民訴法', '刑訴法', '行政法']
areas.each do |area|
  Area.create!(name: area)
  print "."
end
puts " -> areas_complete"

# areas = ['憲法']
# areas.each do |area|
#   Area.create!(name: area)
# end

Category.create!(name: "人権", area_id: 1)
Category.create!(name: "統治", area_id: 1)
Category.create!(name: "民法総則", area_id: 2)
Category.create!(name: "物権", area_id: 2)
Category.create!(name: "担保物権", area_id: 2)
Category.create!(name: "債権総論", area_id: 2)
Category.create!(name: "債権各論", area_id: 2)
Category.create!(name: "親族・相続", area_id: 2)
Category.create!(name: "刑法総論", area_id: 3)
Category.create!(name: "刑法各論（生命・身体に対する罪）", area_id: 3)
Category.create!(name: "刑法各論（自由に対する罪）", area_id: 3)
Category.create!(name: "刑法各論（秘密・名誉に対する罪）", area_id: 3)
Category.create!(name: "刑法各論（財産に対する罪）", area_id: 3)
Category.create!(name: "刑法各論（放火罪・失火罪）", area_id: 3)
Category.create!(name: "刑法各論（文書偽造の罪）", area_id: 3)
Category.create!(name: "刑法各論（風俗に対する罪）", area_id: 3)
Category.create!(name: "刑法各論（国家の作用に対する罪）", area_id: 3)
Category.create!(name: "会社法総則", area_id: 4)
Category.create!(name: "設立", area_id: 4)
Category.create!(name: "株式", area_id: 4)
Category.create!(name: "新株の発行", area_id: 4)
Category.create!(name: "新株予約権", area_id: 4)
Category.create!(name: "機関", area_id: 4)
Category.create!(name: "計算", area_id: 4)
Category.create!(name: "組織再編", area_id: 4)
Category.create!(name: "当事者", area_id: 5)
Category.create!(name: "訴えの提起", area_id: 5)
Category.create!(name: "訴訟の審理と進行", area_id: 5)
Category.create!(name: "証拠", area_id: 5)
Category.create!(name: "裁判によらない訴訟の完結", area_id: 5)
Category.create!(name: "終局判決", area_id: 5)
Category.create!(name: "多数当事者訴訟", area_id: 5)
Category.create!(name: "上訴・再審訴訟手続", area_id: 5)
Category.create!(name: "捜査の原則・捜査の端緒", area_id: 6)
Category.create!(name: "逮捕と勾留", area_id: 6)
Category.create!(name: "証拠の収集・保全", area_id: 6)
Category.create!(name: "被疑者の取調べ", area_id: 6)
Category.create!(name: "公訴の提起", area_id: 6)
Category.create!(name: "公判手続", area_id: 6)
Category.create!(name: "証拠法", area_id: 6)

puts " -> categories_complete"