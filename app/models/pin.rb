class Pin < ActiveRecord::Base
	belongs_to :user

	has_attached_file :image, :styles => { :large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }

	def image_remote_url=(url_value)
		self.image = URI.parse(url_value) unless url_value.blank?
		super
	end

end
