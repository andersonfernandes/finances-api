require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module Finances
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths << Rails.root.join('lib')
    config.api_only = true
  end
end
