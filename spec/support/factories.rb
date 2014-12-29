FactoryGirl.define do
  #
  # sequence :email do |n|
  #   "email#{n}@example.com"
  # end


  factory :user do
    sequence(:email) { |n| "personemailllll#{n}@example.com" }
    password "password"
  end

end
