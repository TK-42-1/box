namespace :db do
  desc "Fill db with sample data"
  task populate: :environment do
    User.create!( name: "test",
                  username: "tester",
                  email: "example@company.com",
                  password: "vader",
                  password_confirmation: "vader",
                  admin: true)
    100.times do |n|
      name = Faker::Name.name
      username = Faker::Name.name
      email = "example-#{n+1}@company.com"
      password = "farts"
      User.create!( name: name,
                    username: username,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end
end