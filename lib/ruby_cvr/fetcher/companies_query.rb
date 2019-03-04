module RubyCvr
  module Fetcher
    class CompaniesQuery
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
          path: 'cvr-permanent/virksomhed/_search',
          body: body,
          parameters: [['search_type', 'scan'], ['scroll', '1m']]
        )
      end

      def body
        JSON.dump({
          'size' => @per_request,
          'query' => {
            'bool' => {
              'must' => [
                {
                  'range' => {
                    'Vrvirksomhed.sidstOpdateret' => {
                      'gte' => @after_date,
                      'time_zone' => '+1:00'
                    }
                  }
                }
              ]
            }
          },
          'filter' => {
            'missing' => {
              'field' => 'Vrvirksomhed.livsforloeb.periode.gyldigTil'
            }
          }
        })
      end

      # Can be used to retrieve historic companies
      # def initial_body
      #   JSON.dump({
      #     'size' => @per_request,
      #     'query' => {
      #       'match_all' => {}
      #     }
      #   })
      # end
    end
  end
end
