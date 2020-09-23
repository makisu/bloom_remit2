# BloomRemit Ruby Library
[![CircleCI](https://circleci.com/gh/makisu/bloom_remit2.svg?style=svg)](https://circleci.com/gh/makisu/bloom_remit2)

Ruby wrapper for BloomRemit's API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloom_remit2'
```

And then execute:

```ruby
bundle install
```

Or install it yourself as:

```ruby
gem install bloom_remit2
```

## Usage

In an initializer:

```ruby
BloomRemit2.configure do |c|
  c.api_token = 'BLOOM-REMIT-API-TOKEN'
  c.api_secret_key = 'BLOOM-REMIT-API-SECRET-KEY'
end
```

## Partners

### Shows partner details
```ruby
# GET /api/v1/partners/:api_token

BloomRemit2::Partner.retrieve
```

## Agents

### Show a list of agents belonging to this partner
```ruby
# GET /api/v1/partners/:api_token/agents
# Return a list of agents created by this partner, sorted by newest first.

BloomRemit2::Agent.list
```

### Show an agent belonging to this partner
```ruby
# GET /api/v1/partners/:api_token/:agents/:id

BloomRemit2::Agent.retrieve('xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')
```

### Create a new agent under this partner
```ruby
# POST /api/v1/partners/:api_token/agents

BloomRemit2::Agent.create('Seoul Branch')
```

### Update the attributes of an agent belonging to this partner
**TODO: Needs to be implemented; update doesn't work at the moment**
```ruby
# PUT /api/v1/partners/:api_token/agents/:id

agent_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
BloomRemit2::Agent.update(
  agent_id,
  name: 'Incheon Branch'
)
```

### Delete an agent belonging to this partner
```ruby
# DELETE /api/v1/partners/:api_token/agents/:id

agent_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Agent.delete(agent_id)
```

## Credits

### Retrieve a credit address
**TODO: Needs to be implemented; this returns a 500 Internal Server Error**
```ruby
# GET /api/v1/partners/:api_token/credits

BloomRemit2::Credit.list
```

### Show a list of credit transactions
```ruby
# GET /api/v1/partners/:api_token/credits/history

BloomRemit2::Credit.history
```

## Rates

### Returns a real-time hash of currency exchange rates. Updates every minute
```ruby
# GET /api/v1/rates

BloomRemit2::Rate.list
=> fetches all the rates

BloomRemit2::Rate.retrieve('USDPHP')
=> fetches one rate
```

The rate returned is defined as:
- The rate that Bloom purchases the base currency (USD) for the counter currency (PHP)
- The rate that a BloomRemit partner can sell the base currency (USD) for the
  counter currency (PHP)
- The amount of PHP (counter currency) that a BloomRemit partner receives from Bloom by exchanging 1 USD (base currency)

## Recipients

### Create a new recipient for a sender belonging to this partner
```ruby
# POST /api/v1/partners/:api_token/recipients

BloomRemit2::Recipient.create(
  sender_id,
  {
    first_name: 'Luis',
    last_name: 'Buenaventura',
    email: 'luis@bloom.solutions',
    mobile: '639171234567',
    address: '251 Salcedo St., Legaspi Village',
    city: 'Makati City',
    province: 'Metro Manila',
    country: 'PH'
  }
)
```

### List all recipients for a user belonging to this partner
```ruby
# GET /api/v1/partners/:api_token/senders/:sender_id/recipients

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Recipient.list(sender_id)
```

### Show details about a recipient of a given user, and their associated remittance IDs
```ruby
# GET /api/v1/partners/:api_token/senders/:sender_id/recipients/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
recipient_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Recipient.retrieve(sender_id, recipient_id)
```

### Update the attributes of a recipient of a user belonging to this partner
```ruby
# PUT /api/v1/partners/:api_token/senders/:sender_id/recipients/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
recipient_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Recipient.update(
  sender_id,
  recipient_id,
  {
    first_name: 'Luis',
    last_name: 'Buenaventura',
    email: 'luis@bloom.solutions',
    mobile: '639171234567',
    address: '251 Salcedo St., Legaspi Village',
    city: 'Makati City',
    province: 'Metro Manila',
    country: 'PH'
  }
)
```

### Delete recipient record of a user belonging to this partner safely
```ruby
# DELETE /api/v1/partners/:api_token/senders/:sender_id/recipients/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
recipient_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Recipient.delete(sender_id, recipient_id)
```

## Remittances

### Show all remittances belonging to the given user
```ruby
# GET /api/v1/partners/:api_token/senders/:sender_id/remittances

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Remittance.list(sender_id)
```

### Initiate a new money transfer by providing a recipient_id and a remittance hash
**TODO: Need to add tests**
```ruby
# POST /api/v1/partners/:api_token/senders/:sender_id/remittances

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
recipient_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Remittance.execute(
  sender_id,
  {
    recipient_id: 1,
    remittance: {
      account_name: 'Luis Buenaventura',
      account_number: '1234567890',
      dest_currency: 'PHP',
      flat_fee_in_orig_currency: 0,
      forex_margin: 0,
      orig_currency: 'PHP',
      paid_in_orig_currency: 0,
      payout_method: 'BPI',
      receivable_in_dest_currency: 25000
    }
  }
)
=> remittance hash, not a BloomRemit2::Remittance
```

### Show information about a given recipient along with their associated remittance
```ruby
# GET /api/v1/partners/:api_token/senders/:sender_id/remittances/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
remittance_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Remittance.retrieve(sender_id, remittance_id)
```

### Cancel a remittance
**TODO: Need to add tests**

Note that this change the status of the remittance to
'cancelled' and refunds the partner credits used, but does not delete it from
the database
```ruby
# DELETE /api/v1/partners/:api_token/senders/:sender_id/remittances/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
remittance_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Remittance.cancel(sender_id, remittance_id)
=> remittance_hash, not a BloomRemit2::Remittance
```

### Returns the total fees for a remittance amount and payout method
**TODO: Needs to be implemented; this returns a 500 Internal Server error**

In order to calculate the cost of a given remittance, you will need to provide
an amount, a currency, and a payout_method. You may provide either the
origin_amount (the money paid by the sender), or the destination_amount (the
money received by the beneficiary), and the calculator will compute the fees
automatically.

If you provide the origin_amount, the calculator will give you the amount
receivable at the destination of the remittance. If you provide the
destination_amount, the calculator will give you the amount that must be paid by
the sender at the point of origin.
```ruby
# POST /api/v1/partners/:api_token/remittances/calculate

BloomRemit2::Remittance.calculate(
  origin_amount: 15000,
  origin_currency: 'PHP',
  payout_method: 'BPI'
)

BloomRemit2::Remittance.calculate(
  destination_amount: 10000,
  destination_currency: 'PHP',
  payout_method: 'BPI'
)

BloomRemit2::Remittance.calculate(
  origin_amount: 125000,
  payout_method: 'BPI'
)
```

## Sender uploads

**TODO: Needs to be implemented**

## Senders

### Show a list of senders belonging to this partner

Returns a list of senders created by this partner, sorted by newest first
```ruby
# GET /api/v1/partners/:api_token/senders

BloomRemit2::Sender.list
```

### Show a sender belonging to this partner
```ruby
# GET /api/v1/partners/:api_token/senders/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Sender.retrieve(sender_id)
```

### Show a sender belonging to this partner by supplying their email address
```ruby
# GET /api/v1/partners/:api_token/senders/find_by_email

BloomRemit2::Sender.find_by_email('helloluis@me.com')
```

### Show a sender belonging to this partner by supplying their mobile
**TODO: Needs to be implemented**
```ruby
# GET /api/v1/partners/:api_token/senders/find_by_mobile

BloomRemit2::Sender.find_by_mobile('639171234567')
```

### Create a new sender under this partner
```ruby
# POST /api/v1/partners/:api_token/senders

BloomRemit2::Sender.create({
  agent_id: '12345-54321',
  sender: {
    first_name: "Luis",
    last_name: "Buenaventura",
    email: "luis@www.bloomremit.net",
    mobile: "+639175551111",
    address: "251 Salcedo St., Legaspi Village",
    city: "Makati City",
    country: "PH"
  }
})
```

### Update the attributes of a sender belonging to this partner
```ruby
# PUT /api/v1/partners/:api_token/senders/:id

BloomRemit2::Sender.update(
  sender_id,
  {
    first_name: 'Luis',
    last_name: 'Buenaventura',
    mobile: "+639175551111",
    address: "251 Salcedo St., Legaspi Village",
    city: "Makati City",
    country: "PH",
    postal_code: "1600",
    identification: {
      url: "http://aws.amazon.com/bucket/image.jpg"
    }
  }
)
```

### Delete a sender belonging to this partner
```ruby
# DELETE /api/v1/partners/:api_token/senders/:id

sender_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
BloomRemit2::Sender.delete(sender_id)
```

## Static

### Lists remittance strategies
**TODO: Needs to be implemented**
```ruby
# GET /api/v1/strategies

BloomRemit2::RemittanceStrategy.list
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/makisu/bloom_remit2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/makisu/bloom_remit2/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BloomRemit2 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/makisu/bloom_remit2/blob/master/CODE_OF_CONDUCT.md).
