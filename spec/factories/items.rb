FactoryBot.define do
  factory :item do
    name { "Product1" }
    price { 10000 }
    buy_month { "2023-1-1" }
    reason { "cause hoge" }
    association :user
  end
end
