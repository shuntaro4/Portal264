require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it "is valid." do
    m = FactoryBot.build(:concert)
    expect(m).to be_valid
  end

  describe "#concert" do
    context "when that is nil" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, concert: nil)
        expect(m).to be_invalid
      end
    end
  end

  describe "#name" do
    context "when that is nil" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, name: nil)
        expect(m).to be_invalid
      end
    end
  end

  describe "#mail" do
    context "when that is nil" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, mail: nil)
        expect(m).to be_invalid
      end
    end
    context "when format is wrong" do
      it "is invalid" do
        m = FactoryBot.build(:reservation, mail: "wrong format mail")
        expect(m).to be_invalid
      end
    end
  end

  describe "#ticket" do
    context "when that is nil" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, ticket: nil)
        expect(m).not_to be_valid
      end
    end
    context "when that is not numeric" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, ticket: "aaa")
        expect(m).not_to be_valid
      end
    end
    context "when that < 0" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, ticket: -1)
        expect(m).not_to be_valid
      end
    end
    context "when that = 100" do
      it "is valid." do
        m = FactoryBot.build(:reservation, ticket: 100)
        expect(m).to be_valid
      end
    end
    context "when that > 100" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, ticket: 101)
        expect(m).not_to be_valid
      end
    end
    context "when that is not integer" do
      it "is invalid." do
        m = FactoryBot.build(:reservation, ticket: 0.5)
        expect(m).not_to be_valid
      end
    end
  end
end
