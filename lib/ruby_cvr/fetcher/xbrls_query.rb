module RubyCvr
  module Fetcher
    class XbrlsQuery
      def initialize(url)
        @url = url
      end

      def execute
        Nokogiri::XML(fetch.body)
      end

      private

      def fetch
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end
      end

      def request
        Net::HTTP::Get.new(uri)
      end

      def uri
        URI.parse(URI.encode(@url))
      end
    end
  end
end
