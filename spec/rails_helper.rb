ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'support/devise'
require 'support/capybara'
require 'support/database_cleaner'
require 'shoulda/matchers'
require 'support/test_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/webkit/matchers'
require 'database_cleaner'

Capybara.javascript_driver = :webkit
Capybara.default_driver = :webkit
Capybara.run_server = true
Capybara.server_port = 7000
Capybara.app_host = "http://localhost:#{Capybara.server_port}"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  RSpec.configure do |config|
    [:controller, :view, :request].each do |type|
      config.include ::Rails::Controller::Testing::TestProcess, :type => type
      config.include ::Rails::Controller::Testing::TemplateAssertions, :type => type
      config.include ::Rails::Controller::Testing::Integration, :type => type
    end
  end

  config.filter_rails_from_backtrace!

  config.infer_spec_type_from_file_location!

  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
  config.include(TestHelper)
end
