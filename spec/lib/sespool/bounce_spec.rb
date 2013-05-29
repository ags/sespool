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
    it "returns the reporting MTA" do
      expect(bounce.reporting_mta).to \
        eq('dsn; aws-ses-mta-svc-iad-1a-i-e6e8e98c.us-east-1.amazon.com')
    end
  end
end
