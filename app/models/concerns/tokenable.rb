module Tokenable
  extend ActiveSupport::Concern

  def generate_token(column_name='auth_token')
    loop do
      # generate 32 character long token
      random_token = SecureRandom.urlsafe_base64(24, false)
      break random_token unless self.class.where(column_name => random_token).exists?
    end
  end

  def api_key
    JWT.encode(jwt_payload, JWT_SECRET)
  end

  def generate_and_set_token
    # add token expiration time in 'auth_token_expires_at'
    self.auth_token = generate_token
  end
end
