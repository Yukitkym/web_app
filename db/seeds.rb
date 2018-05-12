User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
num = 0
while num < 50 do
  content = Faker::Lorem.characters(15)
  if num % 10 == 0
    image_path = File.join(Rails.root, "app/assets/images/america-1.jpg")
  elsif num% 10 == 1
    image_path = File.join(Rails.root, "app/assets/images/america-2.jpg")
  elsif num% 10 == 2
    image_path = File.join(Rails.root, "app/assets/images/england-1.jpg")
  elsif num% 10 == 3
    image_path = File.join(Rails.root, "app/assets/images/england-2.jpg")
  elsif num% 10 == 4
    image_path = File.join(Rails.root, "app/assets/images/canada-1.jpg")
  elsif num% 10 == 5
    image_path = File.join(Rails.root, "app/assets/images/canada-2.jpg")
  elsif num% 10 == 6
    image_path = File.join(Rails.root, "app/assets/images/germany-1.jpg")
  elsif num% 10 == 7
    image_path = File.join(Rails.root, "app/assets/images/germany-2.jpg")
  elsif num% 10 == 8
    image_path = File.join(Rails.root, "app/assets/images/china-1.jpg")
  else
    image_path = File.join(Rails.root, "app/assets/images/china-2.jpg")
  end
  place = Faker::Address.state
  users.each { |user| user.posts.create!(content: content, picture: File.new(image_path), place: place) }
  num = num + 1
end