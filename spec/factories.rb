FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    post { nil }
  end

  factory :post do
    body { "MyText" }
    user { nil }
  end

  sequence :rand_n do |n| 
    n
  end

  factory :user do
    name { "user#{generate(:rand_n)}" }
    email { "#{generate(:rand_n)}@abc.com" }
    password { "12345#{generate(:rand_n)}" }
  end
end