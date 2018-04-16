require 'rails_helper'

RSpec.describe Todo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
	describe "Validations" do
    it "is invalid without title" do
      expect(build(:todo, title: nil)).not_to be_valid
    end
	end
end
