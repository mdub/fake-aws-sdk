require "fake_aws/s3/resource"

describe FakeAWS::S3::Resource do

  let(:fake_s3) { described_class.new }

  describe "#buckets" do

    it "returns a BucketCollection" do
      fake_s3.buckets.should be_kind_of(FakeAWS::S3::BucketCollection)
    end

  end

end
