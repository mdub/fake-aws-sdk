require "fake_aws/s3/bucket_collection"

module FakeAWS
  module S3

    class Resource

      def initialize(options = {})
        @options = options
        @buckets = BucketCollection.new
      end

      attr_reader :buckets
      attr_reader :options

    end

  end
end
