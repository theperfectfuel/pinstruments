require 'test_helper'

class UserFanTest < ActiveSupport::TestCase
	should belong_to(:user)
	should belong_to(:fan)

	test "that creating a fan works without raising an exception" do
		assert_nothing_raised do
			UserFan.create user: users(:bob), fan: users(:tim)
		end
	end

	test "that creating a fan based on user id and fan id works" do
		UserFan.create user_id: users(:bob).id, fan_id: users(:tim).id
		assert users(:bob).fans.include?(users(:tim))
	end
end