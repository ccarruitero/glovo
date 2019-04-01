require "glovo/version"
require "glovo/configuration"
require "glovo/client"
require 'glovo/error/response_error'

module Glovo
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
