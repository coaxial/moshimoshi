# encoding: utf-8

require "aws-sdk"

module AwsHelper
  def self.init
    @credentials = Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
  end

  def self.upload_to_s3(path_to_file, bucket)
    self.init
    s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"], credentials: @credentials)
    extension = "#{path_to_file.match(/(\.[\w]{3})$/)[1]}" || ''
    logger.warn "Uploading file #{path_to_file} to S3 without any extension" if extension.empty?
    key = "#{SecureRandom.hex}#{extension}"

    obj = s3.bucket(bucket).object(key)
    obj.upload_file(path_to_file,
      acl: "public-read",
      storage_class: "REDUCED_REDUNDANCY"
    )
    obj.public_url
  end
end
