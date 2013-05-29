require 'json'
require 'time'

module Sespool
  class Bounce

    def initialize(raw_data)
      message = JSON.parse(JSON.parse(raw_data).fetch('Message'))
      @_mail_data = message.fetch('mail')
      @_bounce_data = message.fetch('bounce')
    end

    def type
      @_bounce_data.fetch('bounceType')
    end

    def sub_type
      @_bounce_data.fetch('bounceSubType')
    end

    def reporting_mta
      @_bounce_data.fetch('reportingMTA')
    end

    def feedback_id
      @_bounce_data.fetch('feedbackId')
    end

    def timestamp
      Time.parse(@_bounce_data.fetch('timestamp'))
    end

    def bounced_recipients
      @_bounced_recipients ||= @_bounce_data.fetch('bouncedRecipients').map { |recipient|
        Recipient.new(
          recipient.fetch('emailAddress'),
          recipient.fetch('status'),
          recipient.fetch('diagnosticCode'),
          recipient.fetch('action')
        )
      }
    end

    def mail
      @_mail ||= Mail.new(
        @_mail_data.fetch('timestamp'),
        @_mail_data.fetch('source'),
        @_mail_data.fetch('messageId'),
        @_mail_data.fetch('destination')
      )
    end

    class Recipient < Struct.new(:email_address, :status, :diagnostic_code, :action)
    end

    class Mail < Struct.new(:raw_timestamp, :source, :message_id, :destination)
      def timestamp
        Time.parse(raw_timestamp)
      end
    end

  end
end
