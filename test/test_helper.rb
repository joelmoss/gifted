# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'gifted'
require 'maxitest/autorun'
require 'minitest/heat'
require 'combustion'

Combustion.path = 'test/internal'
Combustion.initialize! :action_controller, :action_view, :action_mailer, :active_record do
  config.action_mailer.delivery_method = :test
end

class ActiveSupport::TestCase
  def before_setup
    Book.delete_all
    Author.delete_all
    Movie.delete_all
  end
end
