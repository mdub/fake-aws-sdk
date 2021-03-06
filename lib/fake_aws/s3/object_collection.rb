require "fake_aws/s3/s3_object"

module FakeAWS
  module S3

    class ObjectCollection

      def initialize(bucket)
        @bucket = bucket
        @objects = Hash.new do |h, key|
          h[key] = S3Object.new(bucket, key)
        end
      end

      def [](key)
        key = key.to_s
        @objects[key]
      end

      def delete_all
        @objects.clear
      end

      include Enumerable

      def delete_if(&block)
        @objects.delete_if(&block)
      end

      def each(&block)
        @objects.values.select(&:exists?).sort_by(&:key).each(&block)
      end

      def empty?
        !@objects.values.any?(&:exists?)
      end

    end

  end
end
