module RubyCvr
  module CompaniesParser
    class Relation
      def initialize(payload)
        @payload = payload
      end

      def founder?
        organisations.any? do |organisation|
          Organisation.new(organisation).founder?
        end
      end

      def beneficial_owner?
        organisations.any? do |organisation|
          Organisation.new(organisation).beneficial_owner?
        end
      end

      def legal_owner?
        organisations.any? do |organisation|
          Organisation.new(organisation).legal_owner?
        end
      end

      def director?
        organisations.any? do |organisation|
          Organisation.new(organisation).director?
        end
      end

      def executive?
        organisations.any? do |organisation|
          Organisation.new(organisation).executive?
        end
      end

      def name
        Utils.latest(names).try(:[], 'navn')
      end

      def address
        Address.new(Utils.latest(addresses)).execute
      end

      def serialize
        {
          name: name,
          address: address
        }
      end

      private

      def member
        @payload['deltager']
      end

      def names
        member.try(:[], 'navne') || []
      end

      def addresses
        member.try(:[], 'beliggenhedsadresse') || []
      end

      def organisations
        @payload['organisationer'] || []
      end
    end
  end
end
