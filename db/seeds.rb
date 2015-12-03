# create roles

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
 
# create default plans

 plan = Plan.new(
 	name: 'Mensal',
 	is_active: true,
 	is_visible: true,
 	free_days: 15,
 	days: 30
 )

plan.save!

puts "Seed finished"

puts "#{User.count} users created"
puts "#{Role.count} roles created"
puts "#{Plan.count} plans created"
