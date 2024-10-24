require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  entity = FactoryBot.build(:entity)
  let!(:user) { User.create(name: entity.name, password: entity.password) }

  describe 'POST /login' do
    it 'authenticates the user with valid credentials' do
      post '/login', params: { name: user.name, password: user.password }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['token']).to be_present
    end

    it 'rejects invalid credentials' do
      post '/login', params: { name: 'test_user', password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']).to eq('Invalid Credentials')
    end
  end
end
