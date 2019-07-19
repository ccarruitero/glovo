# frozen_string_literal: true

require 'json'
require 'base64'
require 'httparty'
require 'glovo/configuration'

module Glovo
  # a Glovo HTTP Client
  class Client
    # Returns the characteristics of Glovo's working areas.
    # This data will be used to check for valid pickup and delivery locations,
    # and times
    def working_areas
      res = request('get', "https://#{host}/b2b/working-areas")
      parse_response res
    end

    # Provide a price estimation for an order.
    # The response amount will always be in the minor of the currency
    # (e.g. cents for EUR).
    def estimate_cost(order_params)
      res = request('post', "https://#{orders_path}/estimate", order_params)
      parse_response res
    end

    # Create a scheduled or immediate order.
    # If you want to schedule an order, provide a scheduleTime. If you don't,
    # it'll be immediately activated for deliver.
    def create_order(order_params)
      res = request('post', "https://#{orders_path}", order_params)
      parse_response res
    end

    # Retrieve information about a single order.
    def get_order(order_id)
      res = request('get', "https://#{orders_path}/#{order_id}")
      parse_response res
    end

    # Return the position (latitude, longitude) of the courier.
    def track_order(order_id)
      res = request('get', "https://#{orders_path}/#{order_id}/tracking")
      parse_response res
    end

    # Name and contact phone of the courier if the order is active.
    # Error if the order is not active.
    def order_courier(order_id)
      res = request('get', "https://#{orders_path}/#{order_id}/courier-contact")
      parse_response res
    end

    # Cancel a scheduled order. Active orders cannot be canceled.
    def cancel_order(order_id)
      res = request('post', "https://#{orders_path}/#{order_id}/cancel")
      parse_response res
    end

    private

    def host
      test_env = %w[sandbox test]
      prefix = test_env.include?(Glovo.configuration&.env) ? 'stage' : ''
      "#{prefix}api.glovoapp.com"
    end

    def orders_path
      "#{host}/b2b/orders"
    end

    def headers
      api_key, api_secret = Glovo.configuration
      enc = Base64.urlsafe_encode64("#{api_key}:#{api_secret}")
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{enc}"
      }
    end

    def request(method, url, params = {})
      HTTParty.send(method, url, headers: headers, body: params)
    end

    def parse_response(res)
      if res.code != 200
        Glovo::ResponseError.new res.code
      else
        JSON.parse(res.body)
      end
    end
  end
end
