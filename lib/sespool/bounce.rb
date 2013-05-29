require 'json'

module Sespool
  class Bounce
    def initialize(raw_data)
      message = JSON.parse(JSON.parse(raw_data).fetch('Message'))
      @bounce = message.fetch('bounce')
    end

    def type
      @bounce.fetch('bounceType')
    end

    def sub_type
      @bounce.fetch('bounceSubType')
    end

    def reporting_mta
      @bounce.fetch('reportingMTA')
    end
  end
end
