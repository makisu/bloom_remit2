require 'httparty'

module BloomRemit2
  class Client
    class << self
      def get(path, headers = default_get_headers, query: {})
        HTTParty.get(url(path), { query: query, headers: headers })
      end

      def post(path, body = {}, headers = default_post_headers)
        HTTParty.post(url(path), { body: body.to_json, headers: headers })
      end

      def put(path, body = [], headers = default_put_headers)
        HTTParty.put(url(path), { body: URI.encode_www_form(body), headers: headers })
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

      def default_put_headers
        {
          'x-api-secret' => api_secret_key,
          'content-type' => 'application/x-www-form-urlencoded'
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
