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
				get :new, fan_id: users(:tim)
				assert_match /#{users(:tim).profile_name}/, response.body
			end

			should "assign a new user fan" do
				get :new, fan_id: users(:tim)
				assert assigns(:user_fan)
			end

			should "assign a new user fan to the correct fan" do
				get :new, fan_id: users(:tim)
				assert_equal users(:tim), assigns(:user_fan).fan
			end

			should "assign a new user fan to the currently logged in user" do
				get :new, fan_id: users(:tim)
				assert_equal users(:bob), assigns(:user_fan).user
			end

			should "returns a 404 status if no friend is found" do
				get :new, fan_id: 'invalid'
				assert_response :not_found
			end

			should "ask if you really want to fan the user" do
				get :new, fan_id: users(:tim)
				assert_match /Do you want to be #{users(:tim).profile_name}'s fan?/, response.body
			end

		end #closing context when logged in

	end #closing context new

	context "#create" do
		context "when not logged in" do
			should "redirect to the login page" do
				get :new
				assert_response :redirect
				assert_redirected_to login_path
			end
		end

		context "when logged in" do
			setup do
				sign_in users(:tim)
			end

			context "with no fan_id" do
				setup do
					post :create
				end

				should "set the flash error message" do
					assert !flash[:error].empty?
				end

				should "redirect to the site root" do
					assert_redirected_to root_path
				end

			end #closing with no friend_id

			context "with valid fan_id"	do
				setup do
					post :create, fan_id: users(:tim).profile_name
				end

				should "assign a fan object" do
					assert assigns(:fan)
					assert_equal users(:tim), assigns(:fan)
				end

				should "assign a user_fan object" do
					assert assigns(:user_fan)
					assert_equal users(:bob), assigns(:user_fan).user
					assert_equal users(:tim), assigns(:user_fan).fan
				end

			end	#closing with valid fan_id

		end #closing when logged in

	end #closing create

end #closing class