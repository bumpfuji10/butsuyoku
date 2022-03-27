FactoryBot.define do
  factory :item do
    sequence(:id) { |n| n }
    name { "Product1" }
    price { 10000 }
    buy_month { "2022-4-1" }
    reason { "cause hoge" }
    association :user
  end
end
