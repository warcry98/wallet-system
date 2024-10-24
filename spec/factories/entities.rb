FactoryBot.define do
  factory :entity do
    name { "Entity #{rand(1000)}" }
    password { 'password' }
    password_digest { BCrypt::Password.create('password') }

    factory :user, class: 'User' do
      name { "User #{rand(1000)}" }
    end

    factory :team, class: 'Team' do
      name { "Team #{rand(1000)}" }
    end

    factory :stock, class: 'Stock' do
      name { "Stock #{rand(1000)}" }
    end
  end
end
