# frozen_string_literal: true

require 'glovo/version'
require 'glovo/configuration'
require 'glovo/client'
require 'glovo/error/response_error'

# A lib to interact with Glovo API
module Glovo
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
