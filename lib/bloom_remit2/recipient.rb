module BloomRemit2
  class Recipient
    class << self
      def create(sender_id, recipient_hash)
        recipient = Client.post(path(sender_id), recipient_hash)
        initialize_from_hash(recipient['recipient'])
      end

      def list(sender_id)
        recipients = Client.get(path(sender_id))
        recipients.map { |recipient| initialize_from_hash(recipient) }
      end

      def retrieve(sender_id, recipient_id)
        recipient = Client.get("#{path(sender_id)}/#{recipient_id}")
        initialize_from_hash(recipient['recipient'], recipient['remittance_ids'])
      end

      def update(sender_id, recipient_id, recipient_hash)
        body = []
        recipient_hash.each do |k, v|
          body << ["recipient[#{k.to_s.downcase}]", v]
        end
        recipient = Client.put("#{path(sender_id)}/#{recipient_id}", body)
        initialize_from_hash(recipient['recipient'])
      end

      def delete(sender_id, recipient_id)
        message = Client.delete("#{path(sender_id)}/#{recipient_id}").with_indifferent_access
        if message[:success] == "We've successfully deleted that recipient."
          new(
            recipient_id,
            sender_id,
            deleted: true
          )
        end
      end

      private

      def path(sender_id)
        "api/v1/partners/#{BloomRemit2.configuration.api_token}/senders/#{sender_id}/recipients"
      end

      def initialize_from_hash(recipient, remittance_ids=nil)
        recipient = recipient.with_indifferent_access
        new(
          recipient[:id],
          recipient[:sender_id],
          recipient[:first_name],
          recipient[:last_name],
          recipient[:email],
          recipient[:mobile],
          recipient[:address],
          recipient[:city],
          recipient[:state],
          recipient[:country],
          remittance_ids
        )
      end
    end

    attr_reader :id, :sender_id, :first_name, :last_name, :email, :mobile, :address, :city, :province, :country, :remittance_ids, :deleted
    alias :state :province

    def initialize(
      id,
      sender_id,
      first_name=nil,
      last_name=nil,
      email=nil,
      mobile=nil,
      address=nil,
      city=nil,
      province=nil,
      country=nil,
      remittance_ids=nil,
      deleted: false
    )
      @id = id
      @sender_id = sender_id
      @first_name = first_name
      @last_name = last_name
      @email = email
      @mobile = mobile
      @address = address
      @city = city
      @province = province
      @country = country
      @remittance_ids = remittance_ids
      @deleted = deleted
    end
  end
end
