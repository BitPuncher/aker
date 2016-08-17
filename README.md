# Aker

Self-contained Authorization gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aker

## Usage

You will need a private key to sign the requests and decode responses.

```ruby
Aker::Configuration.configure do |config|
  config.private_key = 'my/private/key.pem'
end
```
