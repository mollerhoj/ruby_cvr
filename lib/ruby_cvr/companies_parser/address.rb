module RubyCvr
  module CompaniesParser
    class Address
      def initialize(payload)
        @payload = payload
      end

      def execute
        "#{street} #{house_number}, #{zipcode} #{zip_area}"
      end

      private

      def street
        @payload.try(:[], 'vejnavn')
      end

      def house_number
        [@payload.try(:[], 'husnummerTil'), @payload.try(:[], 'husnummerFra')].compact.join('-')
      end

      def zipcode
        @payload.try(:[], 'postnummer')
      end

      def zip_area
        @payload.try(:[], 'postdistrikt')
      end
    end
  end
end
