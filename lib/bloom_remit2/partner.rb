module BloomRemit2
  class Partner
    class << self
      def retrieve
        response = Client.get(path).with_indifferent_access
        new(
          response[:id],
          response[:name],
          response[:slug],
          response[:domain],
          response[:active],
          response[:orig_currency],
          response[:dest_currency],
          response[:min_amount_in_orig_currency],
          response[:max_amount_in_orig_currency],
          response[:website],
          response[:zip_code],
          response[:country],
          response[:phone],
          response[:email],
          response[:flat_fee_in_orig_currency],
          response[:forex_margin],
          response[:agent_ids],
          response[:credit_in_php],
          response[:credit_in_vnd]
        )
      end

      private

      def path
        "api/v1/partners/#{BloomRemit2.configuration.api_token}"
      end
    end

    attr_reader :id, :name, :slug, :domain, :active, :orig_currency, :dest_currency, :min_amount_in_orig_currency, :max_amount_in_orig_currency, :website, :zip_code, :country, :phone, :email, :flat_fee_in_orig_currency, :forex_margin, :agent_ids, :credit_in_php, :credit_in_vnd

    def initialize(
      id,
      name,
      slug,
      domain,
      active,
      orig_currency,
      dest_currency,
      min_amount_in_orig_currency,
      max_amount_in_orig_currency,
      website,
      zip_code,
      country,
      phone,
      email,
      flat_fee_in_orig_currency,
      forex_margin,
      agent_ids,
      credit_in_php,
      credit_in_vnd
    )
      @id = id
      @name = name
      @slug = slug
      @domain = domain
      @active = active
      @orig_currency = orig_currency
      @dest_currency = dest_currency
      @min_amount_in_orig_currency = min_amount_in_orig_currency
      @max_amount_in_orig_currency = max_amount_in_orig_currency
      @website = website
      @zip_code = zip_code
      @country = country
      @phone = phone
      @email = email
      @flat_fee_in_orig_currency = flat_fee_in_orig_currency
      @forex_margin = forex_margin
      @agent_ids = agent_ids
      @credit_in_php = credit_in_php
      @credit_in_vnd = credit_in_vnd
    end
  end
end
