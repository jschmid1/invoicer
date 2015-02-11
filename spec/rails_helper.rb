# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'devise'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'capybara/rails'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include RSpec::Rails::RequestExampleGroup
  # config.include Devise::TestHelpers, :type => :controller
  config.color = true
  config.formatter = :documentation
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true

  end
end


ActiveRecord::Schema.verbose = false
ActiveRecord::Migration.maintain_test_schema!

Capybara.server do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, Port: port)
end

# This is debug bundle. Use when more details needed
# Rails.logger.level = 0
# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, debug: true, js_errors: true)
# end

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
  config.default_wait_time = 5
  config.match = :one
  config.exact_options = true
  config.ignore_hidden_elements = true
  config.visible_text_only = true
  config.default_selector = :css
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

