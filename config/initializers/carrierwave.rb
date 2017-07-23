CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIHEZHUYZ2OXEIO4A',                        # required
    aws_secret_access_key: '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',                        # required
  }
  config.fog_directory  = 'firehose-david'                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end
