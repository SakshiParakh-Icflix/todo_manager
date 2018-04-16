require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
	describe "Validations" do
    it "is invalid without name" do
      expect(build(:task, name: nil)).not_to be_valid
    end
	end
end
