require "translation_io/api/version"
require "net/http"
require "json"

module TranslationIO::API
  class Error < StandardError; end

  class Segments
    def initialize(api_key:)
      @api_key = api_key
      @base_url = "https://translation.io/api/v1/segments.json"
    end

    def list(target_language, options: {})
      request.get(
        @base_url,
        options.merge("target_language": target_language)
      )
    end

    private

    def request
      Request.new(api_key: @api_key)
    end
  end

  class Request
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
  end

  # Response represents a response from TranslationIO.
  #
  # It is returned when using methods in Request.
  # @see TranslationIO::API::Request

  class Response
    attr_reader :raw_response

    def initialize(response)
      @raw_response = response
    end

    # Was the response code 2xx
    #
    # @return [Boolean]

    def success?
      @raw_response.is_a?(Net::HTTPSuccess)
    end

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
