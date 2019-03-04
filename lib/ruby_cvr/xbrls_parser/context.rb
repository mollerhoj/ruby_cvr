module RubyCvr
  module XbrlsParser
    class Context
      def initialize(payload, root_namespace = nil)
        @payload = payload
        @root_namespace = root_namespace || 'xmlns'
      end

      def id
        @payload.attribute('id').value
      end

      def kind
        return :duration if start_date && end_date && !instant
        return :instant if !start_date && !end_date && instant
        raise 'Unknown kind'
      end

      def instant
        extract_date('instant')
      end

      def start_date
        extract_date('startDate')
      end

      def end_date
        extract_date('endDate')
      end

      def scenario?
        @payload.xpath(".//#{@root_namespace}:scenario").present?
      end

      private

      def extract_date(name)
        nodes = @payload.xpath(".//#{@root_namespace}:#{name}")
        str = Utils.only(nodes).try(:text)
        Date.parse(str) if str
      end
    end
  end
end
