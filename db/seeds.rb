# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'admin', name: 'Admin', email: 'a_turner@tetco.com', password: 'admin', password_confirmation: 'admin', admin: true)
Company.create!(name: 'TETCO')
Company.create!(name: 'Barbarosa Foods')
Company.create!(name: 'Alamo City Truck')
Company.create!(name: 'United Pump')
Department.create!(name: 'Accounts Payable')
Department.create!(name: 'Accounts Receivable')
Department.create!(name: 'Store Packages')
Department.create!(name: 'Non Merch Invoices')