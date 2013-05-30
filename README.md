# Sespool [![Build Status](https://travis-ci.org/ags/sespool.png?branch=master)](https://travis-ci.org/ags/sespool)

Bounce parser for Amazon SES SNS notifications. Currently only supports JSON.

## Usage

```ruby
>> bounce = Sespool::Bounce.new("raw sns json request body")
>> bounce.type
=> 'Transient'
>> bounce.bounced_recipients.first.email_address
=> 'foo@example.com'
>> bounce.mail.message_id
=> '123-456-789'
```

## Example Integration

In a Rails app, you might want to setup your SES SNS bounces be be handled
by something like the following:

```ruby
class SnsController < ApplicationController

  def bounce_notification
    # parse the SNS bounce JSON
    bounce = Sespool::Bounce.new(request.raw_post)

    # do something with it, probably persist it
    EmailBounce.create_from_sns_message(bounce)

    render nothing: true, status: 204
  end

end
```
