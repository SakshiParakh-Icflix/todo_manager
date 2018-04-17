require 'acceptance_helper'

resource "Session" do
  before do
    header 'Accept', 'application/version=1+json'
    header 'Content-Type', 'application/json'
  end

  post "/sessions/sign_in" do
    with_options scope: :session, required: true do
      parameter :login, "User Email"
      parameter :password, "User Password"
      parameter :device_id, "Your device's ID"
    end

    let(:user) { User.first }
		let(:login) { user.email }
    let(:password) { "Test_123" }
    let(:device_id) { "1234567" }
    let(:raw_post) { params.to_json }

    example_request "Login" do
      expect(status).to eq(200)
    end
  end

end
