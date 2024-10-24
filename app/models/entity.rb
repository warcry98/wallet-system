class Entity < ApplicationRecord
  has_secure_password
  has_one :wallet, as: :entity, dependent: :destroy
  after_create :create_wallet

  def generate_token
    SecureRandom.hex(10)
  end

  def self.authenticate(name, password)
    entity = find_by(name: name)
    return nil unless entity&.authenticate(password)
    entity
  end

  private

  def create_wallet
    Wallet.create(entity: self)
  end
end

class User < Entity; end

class Team < Entity; end

class Stock < Entity; end
