class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  has_many :source_transactions, class_name: "Transaction", foreign_key: "source_wallet_id"
  has_many :target_transactions, class_name: "Transaction", foreign_key: "target_wallet_id"

  def calculate_balance
    credits = target_transactions.sum(:amoun)
    debits = source_transactions.sum(:amount)
    credits - debits
  end
end
