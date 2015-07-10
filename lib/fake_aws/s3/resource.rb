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

      def bucket(name)
        buckets[name]
      end

      def create_bucket(options)
        buckets.create(options.fetch(:name))
      end

    end

  end
end
