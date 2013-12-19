require 'test_helper'

class UserTest < ActiveSupport::TestCase
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
