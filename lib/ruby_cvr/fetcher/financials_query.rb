module RubyCvr
  module Fetcher
    class FinancialsQuery
      def initialize(options)
        @per_request = options[:per_request] || 1
        @after_date = options[:after_date] || '1900-01-01'
      end

      def execute
        request.execute['_scroll_id']
      end

      private

      def request
        Request.new(
          method: :post,
          path: 'offentliggoerelser/_search',
          body: body,
          parameters: [['search_type', 'scan'], ['scroll', '1m']]
        )
      end

      def body
        JSON.dump({
          'size' => @per_request,
          'from' => 0,
          'query' => {
            'bool' => {
              'must' => [{
                'range' => {
                  'sidstOpdateret' => {
                    'gte' => @after_date,
                    'time_zone' => '1:00'
                  }
                }
              }]
            }
          },
          'filter' => {
            'exists' => {
              'field' => 'cvrNummer'
            }
          }
        })
      end
    end
  end
end
