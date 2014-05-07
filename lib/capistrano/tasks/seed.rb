namespace :deploy do
  desc "Add initial admin user"
  task :seed => :environment do
    User.create( name: 'Admin', username: 'admin', email: 'a_turner@tetco.com', password: 'vader', admin: true )
  end
end