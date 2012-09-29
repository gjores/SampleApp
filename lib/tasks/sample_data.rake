require 'faker'

namespace :db do
desc "Fill database with sample database"
task :populate => :environment do
		Rake::Task['db:reset'].invoke
		User.create!(:name => "Exempel",
					 :email => "Exempel@exampel.com",
					 :password => "foobar",
					 :password_confirmation => "foobar")

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@example.com"
			password = "foobar"
			User.create!(:name => name,
						 :email => email,
					 	 :password => password,
					 	 :password_confirmation => password)

		end

		User.all(:limit => 6).each do |user|
			50.times do
				user.microposts.create!(:content => Faker::Lorem.sentence(5))
	end
end
end
end