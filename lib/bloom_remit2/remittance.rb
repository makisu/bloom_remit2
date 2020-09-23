module BloomRemit2
  class Remittance
    class << self
      # Initiate a new money transfer by providing a recipient_id and remittance hash
      def execute(sender_id, remittance_hash)
        remittance = Client.post(path(sender_id))
      end

      # Cancel a remittance
      #
      # Note that this changes the status of the remittance to 'cancelled' and
      # refunds the partner credits used, but does not delete it from the database.
      #
      # @param sender_id [String] id of sender associated with this remittance
      # @param remittance_id [String] id of remittance
      def cancel(sender_id, remittance_id)
        remittance = Client.delete(path_with_id(sender_id, remittance_id))
      end

      # Show all remittances belonging to the given sender
      #
      # @param sender_id [String] id of sender to list remittances for
      # @return remittances [Array] array with BloomRemit2::Remittance instances
      def list(sender_id)
        remittances = Client.get(path(sender_id))
        remittances['remittance_ids'].map { |id| new(id) }
      end

      # Show information about a given remittance with their associated recipient
      #
      # All information about the given remittance and recipient are returned with this call.
      # Important fields to note include status and receivable_in_dest_currency.
      #
      # @param sender_id [String] id of sender associated with this remittance
      # @param remittance_id [String] id of remittance
      # @return remittance [BloomRemit2::Remittance]
      def retrieve(sender_id, remittance_id)
        result = Client.get(path_with_id(sender_id, remittance_id)).with_indifferent_access
        remittance = result['remittance'].with_indifferent_access
        recipient = result['recipient'].with_indifferent_access
        new(
          remittance[:id],
          remittance[:partner_id],
          remittance[:orig_currency],
          remittance[:dest_currency],
          remittance[:paid_in_orig_currency],
          remittance[:forex_margin],
          remittance[:flat_fee_in_orig_currency],
          remittance[:payout_method],
          remittance[:status],
          remittance[:account_name],
          remittance[:account_number],
          remittance[:teller_id],
          remittance[:sender_id],
          remittance[:client_external_id],
          recipient: Recipient.new(
            recipient[:id],
            recipient[:sender_id],
            recipient[:first_name],
            recipient[:last_name],
            recipient[:email],
            recipient[:mobile],
            recipient[:address],
            nil,
            nil,
            recipient[:country],
            nil
          )
        )
      end

      # TODO: Returns 500 Internal Server Error
      # Returns the total fees for a given remittance amount and payout method
      # def calculate_fees(payout_method, origin_amount: nil, origin_currency: nil, destination_amount: nil, destination_currency: nil)
      #   remittance = Client.post(path_for_calculate, fees_hash)
      # end

      private

      # TODO: Uncomment when implementing .calculate_fees
      # def path_for_calculate
      #   "api/v1/partners/#{BloomRemit2.configuration.api_token}/remittances/calculate"
      # end

      def path(sender_id)
        "api/v1/partners/#{BloomRemit2.configuration.api_token}/senders/#{sender_id}/remittances"
      end

      def path_with_id(sender_id, remittance_id)
        "#{path(sender_id)}/#{remittance_id}"
      end
    end

    attr_reader :id, :partner_id, :orig_currency, :dest_currency, :paid_in_orig_currency, :forex_margin, :flat_fee_in_orig_currency, :payout_method, :status, :account_name, :account_number, :teller_id, :sender_id, :client_external_id, :recipient

    alias :origin_currency :orig_currency
    alias :destination_currency :dest_currency
    alias :flat_fee_in_origin_currency :flat_fee_in_orig_currency

    def initialize(
      id,
      partner_id=nil,
      orig_currency=nil,
      dest_currency=nil,
      paid_in_orig_currency=nil,
      forex_margin=nil,
      flat_fee_in_orig_currency=nil,
      payout_method=nil,
      status=nil,
      account_name=nil,
      account_number=nil,
      teller_id=nil,
      sender_id=nil,
      client_external_id=nil,
      recipient: nil
    )
      @id = id
      @partner_id = partner_id
      @orig_currency = orig_currency 
      @dest_currency = dest_currency 
      @paid_in_orig_currency = paid_in_orig_currency 
      @forex_margin = forex_margin 
      @flat_fee_in_orig_currency = flat_fee_in_orig_currency
      @payout_method = payout_method 
      @status = status
      @account_name = account_name,
      @account_number = account_number,
      @teller_id = teller_id,
      @sender_id = sender_id
      @client_external_id = client_external_id
      @recipient = recipient
    end
  end
end
