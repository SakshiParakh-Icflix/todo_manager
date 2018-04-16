FactoryBot.define do
  factory :device do
    sign_in_count 1
    current_signin_at "2018-04-16 18:25:43"
    last_signin_at "2018-04-16 18:25:43"
    sequence(:device_id){ |n| "#{Faker::Number.number(6).to_i + n}" }
    auth_token_expires_at "2018-04-16 18:25:43"
		after(:build) do |device|
      device.generate_and_set_token
      device.save
    end
    user nil
  end
end
