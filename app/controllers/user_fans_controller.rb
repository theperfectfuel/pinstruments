class UserFansController < ApplicationController
	before_filter :authenticate_user!, only: [:new]

	def new 
		if params[:fan_id]
			@fan = User.where(profile_name: params[:fan_id]).first
			raise ActiveRecord::RecordNotFound if @fan.nil?
			@user_fan = current_user.user_fans.new(fan: @fan)
		else
			flash[:error] = "Fan required"
		end
	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end

	def create
		if params[:fan_id]
			@fan = User.where(profile_name: params[:fan_id]).first
			@user_fan = current_user.user_fans.new(fan: @fan)
		else
			flash[:error] = "Fan required"
			redirect_to root_path
		end
	end

end
