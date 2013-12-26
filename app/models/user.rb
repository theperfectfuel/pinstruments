class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins
  has_many :user_fans
  has_many :fans, through: :user_fans

  validates :profile_name, presence: true, 
    uniqueness: true, 
    format: {
      with: /\A[a-zA-Z0-9_-]+\Z/,
      message: 'must be formatted correctly.'
    }
  validates :first_name, presence: true
  validates :last_name, presence: true
end
