require './lib/sespool'

def load_fixture(name)
  File.open('./spec/fixtures/' + name).read
end

describe Sespool::Bounce do
  let(:fixture) { load_fixture('fixture_a.json') }
  subject(:bounce) { Sespool::Bounce.new(fixture) }

  describe "#type" do
    it "returns the bounce type" do
      expect(bounce.type).to eq('Transient')
    end
  end

  describe "#sub_type" do
    it "returns the bounce sub type" do
      expect(bounce.sub_type).to eq('General')
    end
  end

  describe "#reporting_mta" do
    it "returns the bounce reporting MTA" do
      expect(bounce.reporting_mta).to \
        eq('dsn; aws-ses-mta-svc-iad-1a-i-e6e8e98c.us-east-1.amazon.com')
    end
  end

  describe "#timestamp" do
    it "returns the bounce timestamp" do
      expect(bounce.timestamp).to eq(Time.parse('2013-05-17T16:26:31.000Z'))
    end
  end

  describe "#feedback_id" do
    it "returns the bounce feedback id" do
      expect(bounce.feedback_id).to \
        eq('0000013eb3506972-88979901-bf0e-31e4-b280-c390f3ef4cd7-000000')
    end
  end

  describe "#bounced_recipients" do
    it "returns a list of bounced recipients" do
      expect(bounce.bounced_recipients.size).to eq(1)
    end

    describe "Bounce::Recipient" do
      subject(:recipient) { bounce.bounced_recipients.first }

      describe "#email_address" do
        it "returns the recipient email address" do
          expect(recipient.email_address).to eq('foo@example.com')
        end
      end

      describe "#status" do
        it "returns the recipient status" do
          expect(recipient.status).to eq('4.4.7')
        end
      end

      describe "#diagnostic_code" do
        it "returns the recipient diagnostic code" do
          expect(recipient.diagnostic_code).to eq(
            'smtp; 550 4.4.7 Message expired: unable to deliver in 840 minutes.'\
            '<421 4.4.0 Unable to lookup DNS for example.com>',
          )
        end
      end

      describe "#action" do
        it "returns the recipient action" do
          expect(recipient.action).to eq('failed')
        end
      end
    end
  end

  describe "#mail" do
    describe "#timestamp" do
      it "returns the mail timestamp" do
        expect(bounce.mail.timestamp).to \
          eq(Time.parse('2013-05-17T02:02:43.000Z'))
      end
    end

    describe "#source" do
      it "returns the sender" do
        expect(bounce.mail.source).to eq('The sender <sender@example.com>')
      end
    end

    describe "#message_id" do
      it "returns the message ID" do
        expect(bounce.mail.message_id).to \
          eq('0000013eb0399348-00ca18d9-5995-4898-17a6-26f5ea0dbea3-000000')
      end
    end

    describe "#destination" do
      it "returns a list of intended recipients" do
        expect(bounce.mail.destination).to \
          eq(['foo@example.com', 'bar@example.com'])
      end
    end
  end
end
