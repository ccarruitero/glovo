require 'json'
require 'base64'
require 'httparty'
require 'glovo/configuration'

module Glovo
  class Client
    # Returns the characteristics of Glovo's working areas.
    # This data will be used to check for valid pickup and delivery locations,
    # and times
    def working_areas
      res = request('get', "https://#{host}/b2b/working-areas")

      if res.code != 200
        Glovo::ResponseError.new "Server returned with #{res.code} status code"
      else
        parse_response res
      end
    end

    # Provide a price estimation for an order.
    # The response amount will always be in the minor of the currency
    # (e.g. cents for EUR).
    def estimate_cost(order_params)
      res = request('post', "https://#{host}/b2b/orders/estimate", order_params)
      parse_response res
    end

    # Create a scheduled or immediate order.
    # If you want to schedule an order, provide a scheduleTime. If you don't,
    # it'll be immediately activated for deliver.
    def create_order(order_params)
      res = request('post', "https://#{host}/b2b/orders", order_params)
      parse_response res
    end

    # Retrieve information about a single order.
    def get_order(order_id)
      res = request('get', "https://#{host}/b2b/orders/#{order_id}")
      parse_response res
    end

    # Return the position (latitude, longitude) of the courier.
    def track_order(order_id)
      res = request('get', "https://#{host}/b2b/orders/#{order_id}/tracking")
      parse_response res
    end

    # Name and contact phone of the courier if the order is active.
    # Error if the order is not active.
    def order_courier(order_id)
      res = request('get', "https://#{host}/b2b/orders/#{order_id}/courier-contact")
      parse_response res
    end

    # Cancel a scheduled order. Active orders cannot be canceled.
    def cancel_order(order_id)
      res = request('post', "https://#{host}/b2b/orders/#{order_id}/cancel")
      parse_response res
    end

    private

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

    def request(method, url, params = {})
      HTTParty.send(method, url, headers: headers, body: params)
    end

    def parse_response(res)
      JSON.parse(res.body)
    end
  end
end
