class V1::SessionsController < V1::BaseController
	skip_before_action :validate_jwt_token!, only: [:create]
  skip_before_action :authenticate!, only: [:create]
	
	def create
    head :bad_request and return false if !params[:session].present? || !params[:session][:device_id].present?
    
		load_user
		render json: { message: "User Not Found" }, status: :unauthorized and return unless @user
	
		if @user.authenticate(params[:session][:password])
			update_user_and_device_fields

      data = @user.as_json(only: [:id, :name, :email])
      data.merge!(@device.as_json(only: [:auth_token, :device_id, :sign_in_count], methods: [:api_key]))

      render json: { message: "Signed In Successfully", data: data }
    else
      render json: { message: "Invalid Email or Password" }, status: :unauthorized
    end
	end

	def destroy
    device = current_user.device_by_auth_token(auth_token).first
    device.auth_token = nil
    if device.save
      render json: { message: "Signed Out Successfully" }
    else
      render json: { message: "Something went wrong please try again" }, status: :unprocessable_entity
    end
  end
	
	private

  def load_user
    @user = User.where("email = ?", params[:session][:login]).first
  end

  def update_user_and_device_fields
    @device = @user.devices.find_or_initialize_by(device_id: params[:session][:device_id])

    @device.update_tracked_fields
    @device.generate_and_set_token
    @device.save
  end

end
