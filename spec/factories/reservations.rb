FactoryBot.define do
  factory :reservation do
    concert { FactoryBot.build(:concert) }
    name "Jone Titor"
    mail "john-titor@testmail.com"
    ticket 5
  end
end
