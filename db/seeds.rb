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
 
 admin.skip_confirmation!
 admin.save!
 
 # Create a moderator
 moderator = User.new(
   name:     'Moderator User',
   email:    'carlos@comex.guru',
   password: 'helloworld',
 )
 moderator.skip_confirmation!
 moderator.save!
 

 # Create a member
 member = User.new(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )


 member.skip_confirmation!
 member.save!


puts "Seed finished"

puts "#{User.count} users created"
