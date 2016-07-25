require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Btg
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Adelaide'

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'outlook.office365.com',
      port:                 587,
      domain:               'uni.flinders.edu.au',
      authentication:       :login,
      user_name:            'corn0102@uni.flinders.edu.au',
      password:             'F76w5vvyv',
      enable_starttls_auto: true  }

      config.paperclip_defaults = {
        :storage => :s3,
        :s3_region => "us-east-1",
        :bucket => "flinders-university",
        :s3_protocol => 'https',
        s3_credentials: {
          access_key_id: "AKIAIVRAT3WLQORQFTSQ",
          secret_access_key: "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"
        }
      }
  end
end
