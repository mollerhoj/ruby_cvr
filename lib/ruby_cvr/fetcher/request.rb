module RubyCvr
  module Fetcher
    class Request
      def initialize(method:, path:, parameters: [], body: '')
        @method = method
        @parameters = parameters
        @body = body
        @path = path
      end

      def execute
        JSON.parse(fetch.body)
      end

      private

      def fetch
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end
      end

      def request
        result = Net::HTTP::Post.new(uri) if @method == :post
        result = Net::HTTP::Get.new(uri) if @method == :get

        result.basic_auth(ENV.fetch('VIRK_USER'), ENV.fetch('VIRK_KEY'))
        result.body = @body
        result
      end

      def uri
        URI.parse("http://distribution.virk.dk/#{@path}?#{parameters}")
      end

      def parameters
        URI.encode_www_form(@parameters)
      end
    end
  end
end
