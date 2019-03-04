module RubyCvr
  module XbrlsParser
    class Report
      def initialize(payload, start_date, end_date)
        @payload = payload
        @start_date = Date.parse(start_date)
        @end_date = Date.parse(end_date)
      end

      def assets
        extract_instant('Assets')
      end

      def equity
        extract_instant('Equity')
      end

      def execute
        assets
      end

      def serialize
        {
          assets: assets,
          equity: equity
        }
      end

      private

      def extract_instant(name)
        @payload.dup.remove_namespaces!.xpath("//#{name}[@contextRef='#{current_instant.id}']").text
      end

      def currentDuration
        Utils.only(contexts_without_scenario.select { |context| context.start_date == @start_date && context.end_date == @end_date })
      end

      def current_instant
        Utils.only(contexts_without_scenario.select { |context| context.instant == @end_date })
      end

      def previous_instant
        Utils.only(contexts_without_scenario.select { |context| context.instant == @start_date })
      end

      def root_namespace
        @payload.root.namespace.prefix || 'xmlns'
      end

      def contexts_without_scenario
        contexts.reject { |context| context.scenario? }
      end

      def contexts
        @payload.xpath(".//#{root_namespace}:context").map do |context|
          Context.new(context, root_namespace)
        end
      end
    end
  end
end
