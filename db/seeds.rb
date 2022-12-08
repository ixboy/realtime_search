puts 'deleting all data...'

User.destroy_all
Article.destroy_all

puts 'criating Users ...'

1.upto(15) do |n|
  user = User.new(
    id: n,
    email: "email#{n}@email.com",
    password: '123456',
    password_confirmation: '123456'
  )

  user.save!

  puts "criating Articles of #{user.email}"

  50.times do
    Article.create(
      user_id: user.id,
      title: Faker::Game.title,
      body: Faker::Lorem.paragraph(sentence_count: 10)
    )
  end
end

p "Created #{User.count} Users and #{Article.count} Articles"
p 'Finished seeding...'
