class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_transaction

  def validate_transaction
    case transaction_type
    when "Credit"
      errors.add(:source_wallet, "must be nil for credits") if source_wallet.present?
      errors.add(:target_wallet, "cannot be nil for credits") if target_wallet.nil?
    when "Debit"
      errors.add(:source_wallet, "cannot be nil for debits") if source_wallet.present?
      errors.add(:target_wallet, "must be nil for debits") if target_wallet.nil?
    when "Transfer"
      errors.add(:base, "Bot wallets must be present for transfers") if source_wallet.nil? || target_wallet.nil?
    end
  end
end
