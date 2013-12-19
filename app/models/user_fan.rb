class UserFan < ActiveRecord::Base
	belongs_to :user
	belongs_to :fan, class_name: 'User', foreign_key: 'fan_id'
end
