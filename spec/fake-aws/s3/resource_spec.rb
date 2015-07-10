require "fake_aws/s3/resource"

describe FakeAWS::S3::Resource do

  let(:fake_s3) { described_class.new }

  describe "#buckets" do

    it "returns a BucketCollection" do
      fake_s3.buckets.should be_kind_of(FakeAWS::S3::BucketCollection)
    end

  end

  describe "#bucket" do

    let(:the_result) { fake_s3.bucket("foo") }

    it "returns the named Bucket" do
      the_result.should be_kind_of(FakeAWS::S3::Bucket)
      the_result.name.should eql("foo")
    end

    it "always returns the same Bucket" do
      fake_s3.bucket("foo").should equal(fake_s3.bucket("foo"))
    end

  end

  describe "#create_bucket" do

    before do
      fake_s3.create_bucket(name: "sydney-bucket")
    end

    it "creates a Bucket" do
      fake_s3.buckets.first.name.should eq("sydney-bucket")
    end

  end

end
