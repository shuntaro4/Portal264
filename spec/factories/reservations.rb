FactoryBot.define do
  factory :reservation do
    concert FactoryBot.build(:concert)
    name "John Titor"
    mail "john-titor@testmail.com"
    ticket 3
  end
end
