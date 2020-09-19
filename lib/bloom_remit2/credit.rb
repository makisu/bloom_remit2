module BloomRemit2
  class Credit
    class << self
      # Show a list of credit transactions
      #
      # Grabs a list of the most recent 100 credit transactions associated with this vendor account.
      # Transactions that add to your credit will have the boolean 'consumed' set to 'false',
      # and transactions that use up your credit (i.e., to pay for remittances) will have it set to 'true'.
      def history
        credits = Client.get("#{path}/history")
        credits.map do |credit|
          new(
            credit['amount_in_php'],
            credit['balance'],
            credit['consumed'],
            credit['created_at'],
            credit['id'],
            credit['item_id'],
            credit['item_type'],
            credit['rate'],
            credit['source_amount'],
            credit['source_currency'],
            credit['target_amount'],
            credit['target_currency'],
            credit['updated_at']
          )
        end
      end

      private

      def path
        "api/v1/partners/#{BloomRemit2.configuration.api_token}/credits"
      end
    end

    attr_reader :amount_in_php, :balance, :consumed, :created_at, :id, :item_id, :item_type, :rate, :source_amount, :source_currency, :target_amount, :target_currency, :updated_at

    def initialize(
      amount_in_php,
      balance,
      consumed,
      created_at,
      id,
      item_id,
      item_type,
      rate,
      source_amount,
      source_currency,
      target_amount,
      target_currency,
      updated_at
    )
      @amount_in_php = amount_in_php
      @balance = balance
      @consumed = consumed
      @created_at = created_at
      @id = id
      @item_id = item_id
      @item_type = item_type
      @rate = rate
      @source_amount = source_amount
      @source_currency = source_currency
      @target_amount = target_amount
      @target_currency = target_currency
      @updated_at = updated_at
    end
  end
end
