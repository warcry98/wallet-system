require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  entity1 = FactoryBot.build(:entity)
  let!(:user1) { User.create(name: entity1.name, password: entity1.password) }
  entity2 = FactoryBot.build(:entity)
  let!(:user2) { User.create(name: entity2.name, password: entity2.password) }

  let!(:wallet1) { Wallet.create(entity: user1, balance: 1000.0) }
  let!(:wallet2) { Wallet.create(entity: user2, balance: 500.0) }

  describe 'POST /transactions' do
    context 'with valid data' do
      it 'creates a transfer transaction' do
        post '/transactions', params: {
          source_wallet_id: wallet1.id,
          target_wallet_id: wallet2.id,
          amount: 100,
          transaction_type: 'Transfer'
        }, headers: { Authorization: 'Bearer some_token' }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['amount'].to_f).to eq(100.0)
      end
    end

    context 'with invalid data' do
      it 'rejects the transaction with invalid amount' do
        post '/transactions', params: {
          source_wallet_id: wallet1.id,
          target_wallet_id: wallet2.id,
          amount: -50,
          transaction_type: 'Transfer'
        }, headers: { Authorization: 'Bearer some_token' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include('Amount must be greater than 0')
      end
    end
  end
end
