require 'rails_helper'

RSpec.describe V1::TodosController, type: :controller do
  let(:user) { create :user }
  let(:device) { create :device, user: user }
	before(:each) do
    request.headers['Accept'] = 'application/version=1+json'
    request.headers['Content-Type'] = 'application/json'
		request.headers['X-API-KEY'] = device.api_key
		request.headers['Authorization'] = device.auth_token
  end
	
	describe "GET #Index" do
    context "success" do
      after(:each) do
        response_body = JSON.parse(response.body)
        expect(response_body['data'].count).to eq(2)
        expect(response).to have_http_status(:success)
      end

      it "must return all todos for that user" do
        todo1 = create(:todo, user_id: user.id)
        todo2 = create(:todo, user_id: user.id)
        get :index
      end
    end
  end	
end
