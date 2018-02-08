require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "is valid." do
    m = FactoryBot.build(:admin)
    expect(m).to be_valid
  end

  describe "#name" do
    context "when that is nil" do
      it "is invalid" do
        m = FactoryBot.build(:admin, name: nil)
        expect(m).to be_invalid
      end
    end
    context "when length is 50" do
      it "is valid." do
        m = FactoryBot.build(:admin, name: "a" * 50)
        expect(m).to be_valid
      end
    end
    context "when length is 51" do
      it "is invalid." do
        m = FactoryBot.build(:admin, name: "a" * 51)
        expect(m).to be_invalid
      end
    end
  end

  describe "#email" do
    context "when that is nil" do
      it "is invalid" do
        m = FactoryBot.build(:admin, email: nil)
        expect(m).to be_invalid
      end
    end
    context "when length is 50" do
      it "is valid." do
        m = FactoryBot.build(:admin, email: "a" * 37 + "@testmail.com")
        expect(m).to be_valid
      end
    end
    context "when length is 51" do
      it "is invalid." do
        m = FactoryBot.build(:admin, email: "a" * 38 + "@testmail.com")
        expect(m).to be_invalid
      end
    end
    context "when format is wrong" do
      it "is invalid" do
        m = FactoryBot.build(:admin, email: "wrong format mail")
        expect(m).to be_invalid
      end
    end
    context "when that is uppercase" do
      it "is saved in downcase." do
        m = FactoryBot.build(:admin, email: "TEST@MAIL.COM")
        m.save
        expect(m.email).to eq("test@mail.com")
      end
    end
  end

  describe "#password" do
    context "when that is nil" do
      it "is invalid." do
        m = FactoryBot.build(:admin, password: nil)
        expect(m).to be_invalid
      end
    end
    context "when length is 6" do
      it "is valid." do
        m = FactoryBot.build(:admin, password: "a" * 6)
        expect(m).to be_valid
      end
    end
    context "when length is 5" do
      it "is invalid." do
        m = FactoryBot.build(:admin, password: "a" * 5)
        expect(m).to be_invalid
      end
    end
  end
end
