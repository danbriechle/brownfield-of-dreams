require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data("<DAN_GIT_API_KEY>") { ENV['DAN_GIT_API_KEY'] }
  config.filter_sensitive_data("<NICO_GIT_API_KEY>") { ENV['NICO_GIT_API_KEY'] }
  # config.allow_http_connections_when_no_cassette = true
end


ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end


SimpleCov.start "rails" do
add_filter "/app/channels/application_cable/channel.rb"
add_filter "/app/channels/application_cable/connection.rb"
add_filter "/app/controllers/about_controller.rb"
add_filter "/app/controllers/admin/api/v1/base_controller.rb"
add_filter "/app/controllers/admin/api/v1/tutorial_sequencer_controller.rb"
add_filter "/app/controllers/concerns/github_session_controller.rb"
add_filter "/app/controllers/get_started_controller.rb"
add_filter "/app/helpers/application_helper.rb"
add_filter "/app/jobs/application_job.rb"
add_filter "/app/mailers/application_mailer.rb"
#ignore files that have no reason to exist or were written and untested because brownfield
end

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
