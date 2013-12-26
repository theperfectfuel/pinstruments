require 'test_helper'

class UserFansControllerTest < ActionController::TestCase
	context "#new" do
		context "when not logged in" do
			should "redirect to the login page" do
				get :new
				assert_response :redirect
			end
		end

		context "when logged in" do
			setup do
				sign_in users(:bob)
			end

			should "get new and return success" do
				get :new
				assert_response :success
			end

			should "should set a flash error if the fan_id params is missing" do
				get :new, {}
				assert_equal "Fan required", flash[:error]
			end

			should "display the fan's name" do
				get :new, fan_id: users(:tim).id
				assert_match /#{users(:tim).profile_name}/, response.body
			end

			should "assign a new user fan" do
				get :new, fan_id: users(:tim).id
				assert assigns(:user_fan)
			end

			should "assign a new user fan to the correct fan" do
				get :new, fan_id: users(:tim).id
				assert_equal users(:tim), assigns(:user_fan).fan
			end

			should "assign a new user fan to the currently logged in user" do
				get :new, fan_id: users(:tim).id
				assert_equal users(:bob), assigns(:user_fan).user
			end

			should "returns a 404 status if no friend is found" do
				get :new, fan_id: 'invalid'
				assert_response :not_found
			end

			should "ask if you really want to fan the user" do
				get :new, fan_id: users(:tim)
				assert_match /Do you really want to fan #{users(:tim).profile_name}?/, response.body
			end
		end
	end
end