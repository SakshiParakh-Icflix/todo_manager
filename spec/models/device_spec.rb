require 'rails_helper'

RSpec.describe Device, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

	describe "Validations" do

    it "is invalid without device_id" do
      expect(build(:device, device_id: nil)).not_to be_valid
    end

  end	
end
