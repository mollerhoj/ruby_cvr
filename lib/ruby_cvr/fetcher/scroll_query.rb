module RubyCvr
  module Fetcher
    class ScrollQuery
      def initialize(scroll_id)
        @scroll_id = scroll_id
      end

      def execute
        data = request.execute

        return {
          payload: data['hits']['hits'],
          scroll_id: data['_scroll_id'],
          retrieved_data: data['hits']['hits'].size,
          total_data: data['hits']['total']
        }
      end

      private

      def request
        Request.new(
          method: :get,
          path: '_search/scroll',
          body: @scroll_id,
          parameters: [['scroll', '1m']]
        )
      end
    end
  end
end
