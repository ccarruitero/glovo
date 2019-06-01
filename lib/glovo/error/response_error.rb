module Glovo
  class ResponseError < StandardError
    def initialize(code)
      super("Server returned with #{code} status code")
    end
  end
end
