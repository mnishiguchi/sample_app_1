ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Get the default Rails tests to show red and green at the appropriate times
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Helper methods to be used by all tests ------------------------------------

  # fill_title method
  include ApplicationHelper

  # return true if a test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # log in a test user (2 ways depending on the type of test)
  # detect the kind of test being used (integration test or not)
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'

    if integration_test?
      # we don't have access to session variables
      # post to the sessions path
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      # manipulate the session method directly
      session[:user_id] = user.id
    end
  end

  #----------------------------------------------------------------------------
  private

    # Return true if inside an integration test, else false.
    def integration_test?
      # The post_via_redirect method is available only in integration tests.
      defined?(post_via_redirect)
    end
end
