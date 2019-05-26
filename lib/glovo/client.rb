require 'json'
require 'base64'
require 'httparty'
require 'glovo/configuration'

module Glovo
  class Client
    def working_areas
      res = request('get', "https://#{host}/b2b/working-areas")

      if res.code != 200
        Glovo::ResponseError.new "Server returned with #{res.code} status code"
      else
        parse_response res
      end
    end

    def host
      prefix = %w[sandbox test].include?(Glovo.configuration&.env) ? 'stage' : ''
      "#{prefix}api.glovoapp.com"
    end

    def headers
      enc = Base64.urlsafe_encode64("#{Glovo.configuration.api_key}:#{Glovo.configuration.api_secret}")
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{enc}"
      }
    end

    def request(method, url)
      HTTParty.send(method, url, headers: headers)
    end

    def parse_response(res)
      JSON.parse(res.body)
    end
  end
end
