module BloomRemit2
  class Sender
    class << self
      # Show a list of senders belonging to this partner
      # @return senders [Array] list of senders created by this partner, sorted by newest first
      def list
        senders = Client.get(path)
        senders.map { |sender| initialize_from_hash(sender) }
      end

      # Show a sender belonging to this partner
      # @return sender [BloomRemit2::Sender] sender belonging to this partner
      def retrieve(id)
        sender = Client.get("#{path}/#{id}")
        initialize_from_hash(sender['user'])
      end

      # Show a sender belonging to this partner by supplying their email address
      # @param email [String]
      # @return sender [BloomRemit2::Sender] sender belonging to this partner
      def find_by_email(email)
        sender = Client.get("#{path}/find_by_email", query: { email: email })
        initialize_from_hash(sender['user'])
      end

      # TODO: Broken because mobile is being shown as scientific notation
      # Show a sender belonging to this partner by supplying their email address
      # @param mobile [String]
      # @return sender [BloomRemit2::Sender] sender belonging to this partner
      # def find_by_mobile(mobile)
      #   sender = Client.get("#{path}/find_by_mobile", query: { email: email })
      #   initialize_from_hash(sender['user'])
      # end

      # Create a new sender under this partner
      def create(sender_hash)
        sender = Client.post(path, sender_hash)
        initialize_from_hash(sender['sender'])
      end

      # Update the attributes of a sender belonging to this partner
      # TODO: Doesn't support identification or proof of address
      # @param sender_id [String] id of the sender to update
      # @param sender_hash [Hash] attributes to update sender
      def update(sender_id, sender_hash)
        body = []
        sender_hash.each do |k, v|
          body << ["user[#{k.to_s.downcase}]", v]
        end
        sender = Client.put("#{path}/#{sender_id}", body)
        initialize_from_hash(sender['user'])
      end

      # Delete a sender belonging to this partner
      # @param sender_id [String] id of sender to delete
      def delete(sender_id)
        message = Client.delete("#{path}/#{sender_id}").with_indifferent_access
        if message[:success] == "We've successfully deleted that user."
          new(
            sender_id,
            deleted: true
          )
        end
      end

      private

      def path
        "api/v1/partners/#{BloomRemit2.configuration.api_token}/senders"
      end

      def initialize_from_hash(sender)
        sender = sender.with_indifferent_access
        new(
          sender[:id],
          sender[:email],
          sender[:first_name],
          sender[:last_name],
          sender[:passport_number],
          sender[:passport_expiry_date],
          sender[:tin],
          sender[:mobile],
          sender[:address],
          sender[:city],
          sender[:state],
          sender[:zip_code],
          sender[:country],
          sender[:birthdate],
          sender[:photo_uid],
          sender[:photo_name],
          sender[:id_photo_uid],
          sender[:id_photo_name],
          sender[:identification_type],
          sender[:identification_number],
          sender[:identification_details],
          sender[:deleted_at],
          sender[:dragonpay_userid],
          sender[:sending_level],
          sender[:occupation],
          sender[:created_at],
          sender[:updated_at]
        )
      end
    end

    attr_reader :id, :email, :first_name, :last_name, :passport_number, :passport_expiry_date, :tin, :mobile, :photo_uid, :photo_name, :id_photo_uid, :id_photo_name, :identification_type, :identification_number, :identification_details, :address, :city, :state, :zip_code, :country, :birthdate, :deleted_at, :dragonpay_userid, :sending_level, :created_at, :updated_at, :deleted

    def initialize(
      id,
      email=nil,
      first_name=nil,
      last_name=nil,
      passport_number=nil,
      passport_expiry_date=nil,
      tin=nil,
      mobile=nil,
      address=nil,
      city=nil,
      state=nil,
      zip_code=nil,
      country=nil,
      birthdate=nil,
      photo_uid=nil,
      photo_name=nil,
      id_photo_uid=nil,
      id_photo_name=nil,
      identification_type=nil,
      identification_number=nil,
      identification_details=nil,
      deleted_at=nil,
      dragonpay_userid=nil,
      sending_level=nil,
      occupation=nil,
      created_at=nil,
      updated_at=nil,
      deleted: false
    )
      @id = id
      @email = email
      @first_name = first_name
      @last_name = last_name
      @passport_number = passport_number
      @passport_expiry_date = passport_expiry_date
      @tin = tin
      @mobile = mobile
      @address = address
      @city = city
      @state = state
      @zip_code = zip_code
      @country = country
      @birthdate = birthdate
      @photo_uid = photo_uid
      @photo_name = photo_name
      @id_photo_uid = id_photo_uid
      @id_photo_name = id_photo_name
      @identification_type = identification_type
      @identification_number = identification_number
      @identification_details = identification_details
      @deleted_at = deleted_at
      @dragonpay_userid = dragonpay_userid
      @sending_level = sending_level
      @occupation = occupation
      @created_at = created_at
      @updated_at = updated_at
      @deleted = deleted
    end
  end
end
