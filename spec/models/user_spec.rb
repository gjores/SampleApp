# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
	before(:each) do
		@attr = {:name => "Petter", :email => "exempel@exempel.com"}
	end
  it "should create at new instance at given valid attribute" do
  	User.create!(@attr)
  end
it "should require a name" do
	no_name_user = User.new(@attr.merge(:email => ""))
	no_name_user.should_not be_valid
	end

it "should require a email" do
	no_email_user = User.new(@attr.merge(:name => ""))
	no_email_user.should_not be_valid
end

it "should not be to long" do
	long_name = "a" * 51
	long_name_user = User.new(@attr.merge(:name => long_name))
	long_name_user.should_not be_valid
	end
it "should accept at valid mail adress" do
	adresses = %w[user.foo@bar.com THE_USER@FIBAR.jp bajs.korc@hej.cko.com]
	adresses.each do |adress|
		valid_email_user = User.new(@attr.merge(:email => adress))
		valid_email_user.should be_valid

		end
	end

it "should reject invalid email" do
	adresses = %w[user,foobar.com THE_USER_at_FIBAR.jp korc@hejcko,com]
	adresses.each do |adress|
		invalid_email_user = User.new(@attr.merge(:email => adress))
		invalid_email_user.should_not be_valid

		end
	end
it "should not be valid" do
	User.create!(@attr)
	user_with_dublicate_email = User.new(@attr)
	user_with_dublicate_email.should_not be_valid
	end
it "should rejct even uppercase email" do
	uppercase_mail = @attr[:email].upcase
	User.create!(@attr.merge(:email => uppercase_mail))
	user_with_dublicate_email = User.new(@attr)
	user_with_dublicate_email.should_not be_valid

	end

end
