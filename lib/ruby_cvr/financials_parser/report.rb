module RubyCvr
  module FinancialsParser
    class Report
      def initialize(payload)
        @payload = payload
      end

      def cvr
        source.try(:[], 'cvrNummer').try(:to_s)
      end

      def start_date
        accounting_period.try(:[], 'startDato')
      end

      def end_date
        accounting_period.try(:[], 'slutDato')
      end

      def case_number
        source.try(:[], 'sagsNummer')
      end

      def pdf_url
        document_by_mime_type('application/pdf')
      end

      def xbrl_url
        document_by_mime_type('application/xml')
      end

      def serialize
        {
          cvr: cvr,
          start_date: start_date,
          end_date: end_date,
          case_number: case_number,
          pdf_url: pdf_url,
          xbrl_url: xbrl_url
        }
      end

      private

      def document_by_mime_type(mime_type)
        Utils.only(documents.select { |document| document.try(:[], 'dokumentMimeType') == mime_type }).try(:[], 'dokumentUrl')
      end

      def documents
        source.try(:[], 'dokumenter') || []
      end

      def accounting_period
        source.try(:[], 'regnskab').try(:[], 'regnskabsperiode')
      end

      def source
        @payload.try(:[], '_source')
      end
    end
  end
end
