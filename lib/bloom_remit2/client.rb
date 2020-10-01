require 'httparty'

module BloomRemit2
  class Client
    class << self
      def get(path, headers = default_get_headers, query: {}, staging: false)
        the_url = url(path)
        the_url = staging_url(path) if staging
        HTTParty.get(the_url, { query: query, headers: headers })
      end

      def post(path, body = {}, staging = false, headers = default_post_headers)
        the_url = url(path)
        the_url = staging_url(path) if staging
        HTTParty.post(the_url, { body: body.to_json, headers: headers })
      end

      def put(path, body = [], headers = default_put_headers, staging: false)
        the_url = url(path)
        the_url = staging_url(path) if staging
        HTTParty.put(the_url, { body: URI.encode_www_form(body), headers: headers })
      end

      def delete(path, headers = default_get_headers, staging: false)
        the_url = url(path)
        the_url = staging_url(path) if staging
        HTTParty.delete(the_url, { headers: headers })
      end

      private

      def base_url
        'https://www.bloomremit.net'
      end

      def staging_url(path)
        "https://staging.bloomremit.net/#{path}"
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
