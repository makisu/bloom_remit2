require 'httparty'

module BloomRemit2
  class Client
    class << self
      def get(path, headers = default_get_headers)
        HTTParty.get(url(path), { headers: headers })
      end

      def post(path, body = {}, headers = default_post_headers)
        HTTParty.post(url(path), { body: body.to_json, headers: headers })
      end

      def put(path, body = {}, headers = default_post_headers)
      end

      def delete(path, headers = default_get_headers)
        HTTParty.delete(url(path), { headers: headers })
      end

      private

      def base_url
        'https://www.bloomremit.net'
      end

      def url(path)
        "#{base_url}/#{path}"
      end

      def api_secret_key
        BloomRemit2.configuration.api_secret_key
      end

      def default_get_headers
        {
          'x-api-secret' => api_secret_key,
          'cache-control' => 'no-cache'
        }
      end

      def default_post_headers
        default_get_headers.merge!(
          {
            'content-type' => 'application/json'
          }
        )
      end
    end
  end
end
