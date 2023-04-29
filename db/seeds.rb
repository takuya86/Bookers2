require 'faker'

puts 'Creating users...'
10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '000000'
  )
end
puts 'Users created successfully!'