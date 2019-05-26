# Glovo

A gem to use [Glovo API](https://api-docs.glovoapp.com/b2b/index.html#introduction)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'glovo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glovo

## Usage

Before you start using thie gem, you need to setup your Glovo's credentials.

```ruby
Glovo.configure do |config|
  config.api_key = 'YOUR_API_KEY'
  config.api_secret = 'YOUR_API_SECRET'
  config.env = 'GLOVO_ENVIRONMENT'
end
```

### initiate client

```ruby
client = Glovo::Client.new
```

### get working areas

```ruby
client.working_areas
```

Note: You still need to decrypt Glovo's working areas polygons. You can found an
example in [wiki]()

### estimate order cost

```ruby
order_params = {
  "scheduleTime": 12344566,
  "description": "A 30cm by 30cm box",
  "addresses": [
    {
      "type": "PICKUP",
      "lat": 0.1,
      "lon": 0.3,
      "label": "Calle la X, 29"
    },
    {
      "type": "DELIVERY",
      "lat": 0.1,
      "lon": 0.3,
      "label": "Calle la X, 30"
    }
  ]
}

client.estimate_order(order_params)
```

### create order

```ruby
client.create_order(order_params)
```

### get order

```ruby
client.get_order(order_id)
```

### track order

```ruby
client.track_order(order_id)
```

### cancel order

```ruby
client.cancel_order(order_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/glovo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Glovo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/glovo/blob/master/CODE_OF_CONDUCT.md).
