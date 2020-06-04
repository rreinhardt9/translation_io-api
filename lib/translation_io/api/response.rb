# frozen_string_literal: true

require "json"

module TranslationIO
  module API
    # Response represents a response from TranslationIO.
    #
    # It is returned when using methods in Request.
    # @see TranslationIO::API::Request
    class Response
      attr_reader :raw_response

      # Constructor
      #
      # @param response [Net::HTTPResponse] raw response from Net::HTTP
      #
      # @return [TranslationIO::API::Response

      def initialize(response)
        @raw_response = response
      end

      # Was the response code 2xx
      #
      # @return [Boolean]

      def success?
        @raw_response.is_a?(Net::HTTPSuccess)
      end

      # Integer representing the HTTP response code
      #
      # @return [Integer] HTTP response code

      def code
        Integer(@raw_response.code)
      end

      # Body of the response
      #
      # @return [Hash] response body

      def body
        return {} if @raw_response.body.strip.empty?

        JSON.parse(@raw_response.body)
      end
    end
  end
end
