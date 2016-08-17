module TestConfiguration
  def configure
    Aker::Configuration.configure do |config|
      config.private_key = 'spec/support/test_rsa.pem'
      config.version = 'v1'
    end
  end
end
