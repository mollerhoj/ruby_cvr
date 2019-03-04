module RubyCvr
  module CompaniesParser
    class Organisation
      class MemberAttribute
        def initialize(payload)
          @payload = payload
        end

        def kind
          @payload['type']
        end

        def values
          @payload['vaerdier'].map do |attribute|
            Value.new(attribute)
          end
        end

        def director?
          values.any?(&:valid?)
        end

        def executive?
          values.any?(&:valid?)
        end

        def beneficial_owner?
          values.any?(&:valid?)
        end

        class Value
          def initialize(payload)
            @payload = payload
          end

          def valid?
            Utils.period_valid?(@payload['periode'])
          end
        end
      end
    end
  end
end
