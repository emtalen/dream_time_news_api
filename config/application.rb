require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module DreamTimeNewsApi
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true

    config.generators do |generate|
      generate.test_framework :rspec
      generate.helper false
      generate.assets false
      generate.view_specs false
      generate.helper_specs false
      generate.routing_specs false
      generate.controller_specs false
      generate.request_specs false
    end
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*",
          headers: :any,
          methods: %i[get post put delete],
          max_age: 0
      end
    end
  end
end
