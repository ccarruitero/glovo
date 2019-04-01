require "glovo/version"
require "glovo/configuration"
require "glovo/client"

module Glovo
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
