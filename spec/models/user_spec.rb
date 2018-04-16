require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
	describe "Validations" do
    it "is invalid without email" do
      expect(build(:user, email: nil)).not_to be_valid
    end
    
		it "is invalid without name" do
      expect(build(:user, name: nil)).not_to be_valid
    end

    it "is invalid without password" do
      expect(build(:user, password: nil)).not_to be_valid
    end

		it "validates password length" do 
      expect(build(:user, password: "test1")).not_to be_valid
      expect(build(:user, password: "test1234")).to be_valid
    end
		
		it "is invalid with repeated email address" do
      user1 = create :user
      user2 = build :user
      expect(user1.valid?).to eq(true)
      user2.email = user1.email
      expect(user2.valid?).to eq(false)
      expect(user2.errors.messages.keys.include?(:email)).to eq(true)
    end
	
	end
end
