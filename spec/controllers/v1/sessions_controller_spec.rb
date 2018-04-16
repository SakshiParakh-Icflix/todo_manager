require 'rails_helper'

RSpec.describe V1::SessionsController, type: :controller do
	before(:each) do
    request.headers['Accept'] = 'application/version=1+json'
    request.headers['Content-Type'] = 'application/json'
  end

	describe "POST #create" do
    context "success" do
      after(:each) do
        token = @device.reload.auth_token
				response_body = JSON.parse(response.body)
        data = @user.as_json(only: [:id, :name, :email])
				data.merge!(@device.as_json(only: [:auth_token, :device_id, :sign_in_count], methods: [:api_key]))
        expect(@user.reload.devices.count).to eq(1)
				expect(response_body['data']).to eq(data)
        expect(response_body["message"]).to eq("Signed In Successfully")
        expect(response).to have_http_status(:success)
      end
			
			it "must authorize and return user" do
        @user = create :user
        @device = create :device, user: @user
        post :create, params: { session: { login: @user.email, password: @user.password, device_id: @device.device_id } }
      end
    end

    context "failure" do
      it "must return bad request when params are invalid" do
        post :create, params: { session: {} }
        expect(response).to have_http_status(:bad_request)
      end

      it "must return unauthorized when user not present" do
        post :create, params: { session: { email: "random@ramdn.com", password: "123456", device_id: "1234567" } }
				expect(JSON.parse(response.body)["message"]).to eq("User Not Found")
        expect(response).to have_http_status(:unauthorized)
      end

      it "must return unauthorized when password is invalid" do
        user = create :user
        post :create, params: { session: { email: user.email, password: "123456", device_id: "1234567" } }
				expect(JSON.parse(response.body)["message"]).to eq("User Not Found")
	      expect(response).to have_http_status(:unauthorized)
      end
    end

  end		
	
end
