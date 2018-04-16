class Device < ApplicationRecord
  include Tokenable
  include Trackable
	
	belongs_to :user
	
	validates :device_id, presence: true, uniqueness: { scope: :user_id }

	def jwt_payload
    { user_id: user_id.to_s, device_id: device_id }
  end
end
