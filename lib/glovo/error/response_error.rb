# frozen_string_literal: true

module Glovo
  # for not success responses
  class ResponseError < StandardError
    def initialize(code)
      super("Server returned with #{code} status code")
    end
  end
end
