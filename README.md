Sespool
=======

Bounce parser for Amazon SES SNS notifications. Currently only supports JSON.

Usage
=====

```ruby
>> bounce = Sespool::Bounce.new("raw sns json request body")
>> bounce.type
=> 'Transient'
>> bounce.bounced_recipients.first.email_address
=> 'foo@example.com'
>> bounce.mail.message_id
=> '123-456-789'
```
