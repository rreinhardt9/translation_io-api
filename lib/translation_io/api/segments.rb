# frozen_string_literal: true

module TranslationIO
  module API
    # Client for segment endpoints
    class Segments
      def initialize(api_key:)
        @api_key = api_key
        @base_url = "https://translation.io/api/v1/segments"
      end

      def list(target_language, options = {})
        request.get(
          @base_url,
          options.merge("target_language": target_language)
        )
      end

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

      def add_tag(segment_id, name:)
        request.post(@base_url + "/#{segment_id}/add_tag", { name: name })
      end

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
