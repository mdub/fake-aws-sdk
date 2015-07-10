require "fake_aws/s3/resource"

module FakeAWS

  module S3

    def self.new(*args)
      Resource.new(*args)
    end

  end

end
