# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '3.3'
Rails.application.config.assets.paths << Rails.root.join('/app/assets/fonts')
Rails.application.config.assets.paths << Rails.root.join('/app/assets/css/fonts')
Rails.application.config.assets.paths << Rails.root.join('/app/assets/css/fonts/lato')
Rails.application.config.assets.precompile += %w( jquery.ui.touch-punch.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )