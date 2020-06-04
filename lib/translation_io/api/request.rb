# frozen_string_literal: true

require "net/http"
require "json"

module TranslationIO
  module API
    # An HTTP request
    class Request
      # Constructor
      #
      # @param api_key [String] translation.io api key
      #
      # @return [TranslationIO::API::Request]

      def initialize(api_key:)
        @api_key = api_key
      end

      # Get request
      #
      # @param uri [String]
      # @param data [Hash] the JSON payload for this request
      #
      # @return [TranslationIO::API::Response]

      def get(uri, data)
        uri = URI.parse(uri)
        req = Net::HTTP::Get.new(uri)

        req["Content-Type"] = "application/json"
        req["X-api-key"] = @api_key
        req.body = data.to_json

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end

        Response.new(res)
      end

      # Post request
      #
      # @param uri [String]
      # @param data [Hash] the JSON payload for this request
      #
      # @return [TranslationIO::API::Response]

      def post(uri, data)
        uri = URI.parse(uri)
        req = Net::HTTP::Post.new(uri)

        req["Content-Type"] = "application/json"
        req["X-api-key"] = @api_key
        req.body = data.to_json

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end

        Response.new(res)
      end
    end
  end
end
