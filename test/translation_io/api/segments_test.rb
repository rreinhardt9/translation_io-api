# frozen_string_literal: true

require "test_helper"

module TranslationIO
  module API
    class SegmentsTest < Minitest::Test
      def test_list_segments
        stub = stub_request(:get, segments_url)
          .with(
            body: hash_including({ "target_language": "fr" }),
            headers: expected_headers
          )
          .to_return(status: 200, body: expected_list_response.to_json)

        client = TranslationIO::API::Segments.new(api_key: "test")

        response = client.list("fr")

        assert_equal expected_list_response, response.body
        assert_equal 200, response.code

        assert_requested(stub)
      end

      def test_list_by_tag
        stub = stub_request(:get, segments_url)
          .with(
            body: hash_including(
              {
                "target_language": "fr",
                "tag": "proofread"
              }
            ),
            headers: expected_headers
          )
          .to_return(status: 200, body: expected_list_by_tag_response.to_json)

        client = TranslationIO::API::Segments.new(api_key: "test")

        response = client.list("fr", tag: "proofread")

        assert_equal expected_list_by_tag_response, response.body
        assert_equal 200, response.code

        assert_requested(stub)
      end

      private

      def expected_headers
        {
          "Content-Type" => "application/json",
          "X-Api-Key" => "test"
        }
      end

      def segments_url
        "https://translation.io/api/v1/segments"
      end

      def expected_list_by_tag_response
        {
          "segments" => [
            {
              "id" => 2,
              "source_id" => "b9d78193f955836a4ffd2ace3d06c725f605a8fdf142522908dc5605fce30f72",
              "target_language" => "fr",
              "type" => "source",
              "source" => "Good afternoon",
              "target" => "Bon après-midi",
              "tags" => [
                "proofread"
              ]
            }
          ]
        }
      end

      def expected_list_response
        {
          "segments" => [
            {
              "id" => 1,
              "source_id" => "85af68954641ff0400756bc3b93de505680e621e834040a63732621e659c1d82",
              "target_language" => "fr",
              "type" => "source",
              "source" => "Hello",
              "target" => "Bonjour"
            },
            {
              "id" => 2,
              "source_id" => "b9d78193f955836a4ffd2ace3d06c725f605a8fdf142522908dc5605fce30f72",
              "target_language" => "fr",
              "type" => "source",
              "source" => "Good afternoon",
              "target" => "Bon après-midi",
              "tags" => [
                "proofread"
              ]
            },
            {
              "id" => 3,
              "source_id" => "6c8e8a8f5a483490d0ca0cb2eb73f710cc7e1c918cf435bfcb4cf9441a4ecf91",
              "target_language" => "fr",
              "type" => "key",
              "key" => "goodbye.message",
              "source" => "Goodbye",
              "target" => ""
            }
          ]
        }
      end
    end
  end
end
