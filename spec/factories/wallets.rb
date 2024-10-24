FactoryBot.define do
  factory :wallet do
    association :entity, factory: :user
    balance { 0.0 }
  end
end
