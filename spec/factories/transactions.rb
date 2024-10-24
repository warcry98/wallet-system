FactoryBot.define do
  factory :transaction do
    amount { rand(1.0..100.0) }
    transaction_type { 'Transfet' }
    association :source_wallet, factory: :wallet
    association :target_wallet, factory: :wallet
  end
end
