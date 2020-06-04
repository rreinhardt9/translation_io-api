# frozen_string_literal: true

require "test_helper"

module TranslationIO
  module API
    class ResponseTest < Minitest::Test
      def test_successful_response
        mock_response = OpenStruct.new(
          code: "200",
          body: { segments: [] }.to_json
        )

        response = Response.new(mock_response)

        assert_equal 200, response.code
        assert_equal({ "segments" => [] }, response.body)
      end

      def test_404_response
        mock_response = OpenStruct.new(
          code: "404",
          body: { errors: ["Could not find any segment with this id."] }.to_json
        )

        response = Response.new(mock_response)

        assert_equal 404, response.code
        assert_equal(
          { "errors" => ["Could not find any segment with this id."] },
          response.body
        )
      end
    end
  end
end
