require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
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

      it "must return all tasks for a particular todo" do
        todo = create :todo, user: user_id
				task1 = create(:task, todo_id: user.id)
        task2 = create(:task, todo_id: tas.id)
        get :index
      end
    end
  end	
end

end
