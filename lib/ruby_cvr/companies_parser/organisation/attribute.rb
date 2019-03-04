module RubyCvr
  module CompaniesParser
    class Organisation
      class Attribute
        def initialize(payload)
          @payload = payload
        end

        def kind
          @payload['type']
        end

        def beneficial_owner?
          values.any? do |value|
            value.beneficial_owner?
          end
        end

        def director?
          values.any? do |value|
            value.director?
          end
        end

        def executive?
          values.any? do |value|
            value.executive?
          end
        end

        def values
          @payload['vaerdier'].map do |attribute|
            Value.new(attribute)
          end
        end

        class Value
          def initialize(payload)
            @payload = payload
          end

          def valid?
            Utils.period_valid?(@payload['periode'])
          end

          def director?
            value == 'Bestyrelse' && valid?
          end

          def executive?
            value == 'Direktion' && valid?
          end

          def beneficial_owner?
            value == 'Reelle ejere' && valid?
          end

          private

          def value
            @payload['vaerdi']
          end
        end
      end
    end
  end
end
