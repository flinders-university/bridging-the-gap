require_relative 'boot'

require 'rails/all'

require 'CSV'

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
      address:              ENV['FU_E_OUTLOOK_SMTP'],
      port:                 587,
      domain:               ENV['FU_E_DOMAIN'],
      authentication:       :login,
      user_name:            ENV['FU_E_USER'],
      password:             ENV['FU_E_PASS'],
      enable_starttls_auto: true  }

      config.paperclip_defaults = {
        :storage => :s3,
        :s3_region => ENV['AWS_REGION'],
        :bucket => ENV['FU_BUCKET_ID'],
        :s3_protocol => 'https',
        s3_credentials: {
          access_key_id: ENV['FU_AWS_ACCESS_KEY'],
          secret_access_key: ENV['FU_AWS_SECRET_KEY']
        }
      }
  end
end
