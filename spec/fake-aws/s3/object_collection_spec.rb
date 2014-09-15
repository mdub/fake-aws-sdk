require "fake_aws/s3/object_collection"

describe FakeAWS::S3::ObjectCollection do

  let(:bucket) { double("BUCKET") }
  let(:objects) { FakeAWS::S3::ObjectCollection.new(bucket) }

  it "starts empty" do
    objects.should be_empty
  end

  describe "#[]" do

    it "returns an S3Object" do
      objects["foo"].should be_kind_of(FakeAWS::S3::S3Object)
    end

    it "always returns the same S3Object" do
      objects["foo"].should equal(objects["foo"])
    end

    it "passes along the object key" do
      objects["foo"].key.should eq("foo")
    end

    it "converts Symbol keys to String" do
      objects["foo"].should equal(objects[:foo])
    end

  end

  it "is Enumerable" do
    objects.should be_kind_of(Enumerable)
  end

  context "after writing some objects" do

    before do
      objects["c"].write("CONTENT")
      objects["a"].write("CONTENT")
      objects["b"].write("CONTENT")
    end

    it "is no longer empty" do
      objects.should_not be_empty
    end

    describe "#each" do

      it "yields objects in alphabetical order" do
        objects.map(&:key).should eq(%w(a b c))
      end

    end

    describe "#delete_all" do

      it "removes all the objects" do
        objects.delete_all
        objects.should be_empty
      end

    end

    describe "#delete_if" do

      before do
        objects["hello/a.txt"].write("CONTENT")
        objects["world/a.txt"].write("CONTENT")
        objects.delete_if { |key| key =~ /hello/ }
      end

      it "deletes the hello folder" do
        expect(objects["hello/a.txt"]).to_not exist
      end

      it "does not delete the world folder" do
        expect(objects["world/a.txt"]).to exist
      end
      
    end

  end

  context "after referencing some objects (without writing content)" do

    before do
      objects["a"]
      objects["b"]
    end

    it "is still considered empty" do
      objects.should be_empty
    end

    describe "#each" do

      it "yields nothing" do
        objects.map(&:key).should be_empty
      end

    end

  end

end
