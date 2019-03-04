module RubyCvr
  module CompaniesParser
    class Company
      def initialize(payload)
        @payload = payload
      end

      def status
        raise @payload.inspect unless vrvirksomhed
        vrvirksomhed['nyesteStatus']
      end

      def cvr
        vrvirksomhed['cvrNummer'].to_s
      end

      def name
        virksomhedMetadata.try(:[], 'nyesteNavn').try(:[], 'navn')
      end

      def address
        Address.new(virksomhedMetadata['nyesteBeliggenhedsadresse']).execute
      end

      def kind
        Utils.vertify_in(Constants::KIND_OPTIONS.map { |x| x[:abbreviation] }, virksomhedMetadata.try(:[], 'nyesteVirksomhedsform').try(:[], 'kortBeskrivelse'))
      end

      def main_industry
        virksomhedMetadata.try(:[], 'nyesteHovedbranche').try(:[], 'branchetekst')
      end

      def phone
        Utils.latest(vrvirksomhed.try(:[], 'telefonNummer')).try(:[], 'kontaktoplysning')
      end

      def founded_date
        virksomhedMetadata['stiftelsesDato']
      end

      def founders
        relations_where(:founder?)
      end

      def beneficial_owners
        relations_where(:beneficial_owner?)
      end

      def legal_owners
        relations_where(:legal_owner?)
      end

      def directors
        relations_where(:director?)
      end

      def executives
        relations_where(:executive?)
      end

      def serialize
        {
          status: status,
          cvr: cvr,
          name: name,
          address: address,
          kind: kind,
          main_industry: main_industry,
          phone: phone,
          founded_date: founded_date,
          founders: founders.map(&:serialize),
          beneficial_owners: beneficial_owners.map(&:serialize),
          legal_owners: legal_owners.map(&:serialize),
          directors: directors.map(&:serialize),
          executives: executives.map(&:serialize)
        }
      end

      private

      def relations_where(method)
        relations.select do |relation|
          Relation.new(relation).send(method)
        end.map do |relation|
          Relation.new(relation)
        end
      end

      def vrvirksomhed
        @payload.try(:[], '_source').try(:[], 'Vrvirksomhed')
      end

      def virksomhedMetadata
        vrvirksomhed.try(:[], 'virksomhedMetadata')
      end

      def relations
        vrvirksomhed.try(:[], 'deltagerRelation')
      end
    end
  end
end
