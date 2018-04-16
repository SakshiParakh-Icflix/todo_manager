class User < ApplicationRecord
	has_many :devices
	has_many :todos
	has_secure_password validations: false
	
	validates :name, :email, presence: true
	validates :email, uniqueness: true
	validates :password, length: {minimum: 6}, presence: true
	
	def device_by_auth_token(token)
    self.devices.where(auth_token: token)
  end

  def authorize_token?(token)
    token && self.device_by_auth_token(token).exists?
  end

end
