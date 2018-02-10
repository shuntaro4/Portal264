require 'rails_helper'

RSpec.describe Concert, type: :model do
  it "is valid." do
    m = FactoryBot.build(:concert)
    expect(m).to be_valid
  end

  describe "#title" do
    context "when that is nil" do
      it "is invalid" do
        m = FactoryBot.build(:concert, title: nil)
        expect(m).to be_invalid
      end
    end
  end
end
