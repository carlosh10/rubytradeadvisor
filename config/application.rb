require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rubytradeadvisor
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # add fonts to assets precompile pipeline
    config.assets.precompile << Proc.new { |path|
      if path =~ /\.(eot|svg|ttf|woff)\z/
        true
      end
    }

    # brazil default locale
    config.i18n.default_locale = :'pt-BR'

    # iugu api setting
    Iugu.api_key = "0a5ecb4cc3611b327f8bf757551c5ab4"

    # hubspot api settings
    Hubspot.configure(hapikey: "ec235818-86ae-4eed-b113-a2814b2f2e71")

    # config.assets.prefix = ''
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.x.elasticsearch.credentials = [
      { host: '104.197.79.244',
        port: '9400',
        user: 'tradeadvisor_user',
        password: 'Pinho14',
        scheme: 'http'
      } 
  ]



  end
end
