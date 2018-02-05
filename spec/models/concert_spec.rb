require 'rails_helper'

RSpec.describe Concert, type: :model do
  it "is valid with a title" do
    m = FactoryBot.build(:concert)
    expect(m).to be_valid
  end
  it "is invalid without a title" do
    m = FactoryBot.build(:concert, title:'')
    expect(m).not_to be_valid
  end
end
