# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



['registered', 'banned', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end


 # Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin@pinho.com',
   password: 'Pinho@15',
 )

 admin.role = Role.find_by({name: 'admin'})
 
 admin.skip_confirmation!
 admin.save!
 
puts "Seed finished"

puts "#{User.count} users created"
