class V1::BaseController < ApplicationController
	before_action :validate_jwt_token!
  before_action :authenticate!

  X_API_KEY = 'X-Api-Key'
  AUTHORIZATION = 'Authorization'

  def current_user
    @current_user ||= User.where(id: jwt_payload.first["user_id"]).first
  end

  def auth_token
    @auth_token ||= request.headers[AUTHORIZATION]
  end

  def jwt_payload
    @jwt_payload ||= JWT.decode(request.headers[X_API_KEY], JWT_SECRET)
  end
	
	private

  def validate_jwt_token!
    jwt_payload
  rescue JWT::DecodeError
    head :unauthorized
    return false
  end

  def authenticate!
		(token_invalid and return) unless current_user&.authorize_token?(auth_token)
  rescue NameError
    token_invalid and return
  end

  def token_invalid
    render json: { message: "Invalid authentication token" }, status: :unauthorized
  end

end
