require_relative 'boot'

require 'rails/all'

require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Btg
  class Application < Rails::Application
    ENV['version'] = "213.93"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Adelaide'

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

    Paperclip.options[:content_type_mappings] = {:svg => "text/html"}
  end
end
