class UserFansController < ApplicationController
	before_filter :authenticate_user!, only: [:new]
	def new 
		if params[:fan_id]
			@user_fan = current_user.user_fans.new(fan: @fan)
		else
			flash[:error] = "Fan required"
		end
	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end
end
