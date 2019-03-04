# Organisations represent the relation between the entity and the company
module RubyCvr
  module CompaniesParser
    class Organisation
      MAIN_KIND_OPTIONS = %w[LEDELSESORGAN
                             TEGNINGSBERETTIGEDE
                             REVISION
                             STIFTERE
                             FULDT_ANSVARLIG_DELTAGERE
                             SÆRLIGE_FINANSIELLE_DELTAGERE
                             HOVEDSELSKAB
                             FUSION
                             SPALTNING
                             REGISTER
                             FORSIKRINGER
                             HVIDVASK].freeze

      def initialize(payload)
        @payload = payload
      end

      def main_kind
        Utils.vertify_in(MAIN_KIND_OPTIONS, @payload['hovedtype'])
      end

      def founder?
        main_kind == 'STIFTERE'
      end

      def legal_owner?
        return false
      end

      def beneficial_owner?
        return false unless part_of_register?
        attributes.any?(&:beneficial_owner?) && member_attributes.any?(&:beneficial_owner?)
      end

      def director?
        return false unless part_of_management?
        attributes.any?(&:director?) && member_attributes.any?(&:director?)
      end

      def executive?
        return false unless part_of_management?
        attributes.any?(&:executive?) && member_attributes.any?(&:executive?)
      end

      private

      def part_of_register?
        main_kind == 'REGISTER'
      end

      def part_of_management?
        main_kind == 'LEDELSESORGAN'
      end

      def attributes
        @payload['attributter'].map do |attribute|
          Attribute.new(attribute)
        end
      end

      def member_attributes
        member_attributes = @payload.try(:[], 'medlemsData').first.try(:[], 'attributter') || []

        member_attributes.map do |member_attribute|
          MemberAttribute.new(member_attribute)
        end
      end
    end
  end
end
