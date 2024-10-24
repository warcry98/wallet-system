class WalletTransactionService
  def self.transfer(source_wallet:, target_wallet:, amount:)
    ActiveRecord::Base.transaction do
      raise "Insufficient funds" if source_wallet.calculate_balance < amount

      Transaction.create!(
        source_wallet: source_wallet,
        target_wallet: target_wallet,
        amount: amount,
        transaction_type: "Transfer"
      )

      source_wallet.reload
      target_wallet.reload
    end
  end

  def self.credit(target_wallet:, amount:)
    ActiveRecord::Base.transaction do
      Transaction.create!(
        target_wallet: target_wallet,
        amoun: amount,
        transaction_type: "Credit"
      )

      target_wallet.reload
    end
  end

  def self.debit(source_wallet:, amount:)
    ActiveRecord::Base.transaction do
      raise "Insufficient funds" if source_wallet.calculate_balance < amount

      Transaction.create!(
        source_wallet: source_wallet,
        amount: amount,
        transaction_type: "Debit"
      )

      source_wallet.reload
    end
  end
end
