FactoryGirl.define do
  factory :review do
    content "Book sucks"
    user
    book
    rating 3
  end
end
