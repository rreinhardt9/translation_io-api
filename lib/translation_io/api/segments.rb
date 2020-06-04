# frozen_string_literal: true

module TranslationIO
  module API
    # Client for segment endpoints
    class Segments
      def initialize(api_key:)
        @api_key = api_key
        @base_url = "https://translation.io/api/v1/segments"
      end

      # List segments for target language
      #
      # @param target_language [String] Target language code (from
      #   https://translation.io/docs/languages). Example: "es"
      # @param options [Hash] optional params to pass with the call to list
      # @option options [String] :query Query segments to returns only the
      #   ones that contain query value in their key, source, target (with
      #   plurals), context, comment or references properties.
      #   Note: that query is case-insensitive.
      # @option options [String] :type ("all") Filter by type of segments.
      #   Should be key, source or all.
      # @option options [String] :state ("all") Filter by state of segments.
      #   Should be translated, untranslated or all.
      # @option options [String] :tag Filter by tag. Only returns segments
      #   that are tagged with tag value.
      #
      # @return [TranslationIO::API::Response] response

      def list(target_language, options = {})
        request.get(
          @base_url,
          options.merge("target_language": target_language)
        )
      end

      # Create a segment
      #
      # @param target_language [String] Target language code (from
      #   https://translation.io/docs/languages). Example: "es"
      # @param type [String] Segment type. Should be "key" or "source".
      # @param key [String] Key associated with the text to be translated.
      #   Only for "key" type. Example: "home.call_to_action.bottom"
      # @param source [String] Source text.  Example: "Click here to subscribe"
      #
      # @return [TranslationIO::API::Response] response containing created
      #   segment.

      def create(target_language, type:, key:, source:)
        request.post(
          @base_url, {
            target_language: target_language,
            type: type,
            key: key,
            source: source
          }
        )
      end

      # Add a tag to a segment
      #
      # @param segment_id [String, Integer] The ID of the segment
      # @param name [String] The name of the tag to add
      #
      # @note a unique color will be attributed to the tag. If this tag
      #   already exists in the project, the same color will be reused.
      # @note if this tag is already added to the segment, nothing will change
      #   and no error will be triggered.
      #
      # @return [TranslationIO::API::Response] response containing updated
      #   segment

      def add_tag(segment_id, name:)
        request.post(@base_url + "/#{segment_id}/add_tag", { name: name })
      end

      # Remove a tag from a segment
      #
      # @param segment_id [String, Integer] The ID of the segment
      # @param name [String] The name of the tag to remove
      #
      # @note if this tag doesn't exist or is not linked to this segment,
      #   nothing will change and no error will be triggered.
      #
      # @return [TranslationIO::API::Response] response containing updated
      #   segment

      def remove_tag(segment_id, name:)
        request.post(@base_url + "/#{segment_id}/remove_tag", { name: name })
      end

      private

      def request
        Request.new(api_key: @api_key)
      end
    end
  end
end
