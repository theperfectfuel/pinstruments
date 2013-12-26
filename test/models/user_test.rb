require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "A user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "A user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "A user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "A user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:bob).profile_name
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "A user should have a profile name without spaces" do
		user = User.new
		user.profile_name = "My profile name with spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly.")
	end

	should have_many(:user_fans)
	should have_many(:fans)

	test "that no error is raised when trying to access a fan list" do
		assert_nothing_raised do
			users(:bob).fans
		end
	end

	test "that creating fans on a user works" do
		users(:bob).fans << users(:stew)
		users(:bob).fans.reload
		assert users(:bob).fans.include?(users(:stew))
	end
end
