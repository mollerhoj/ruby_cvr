module RubyCvr
  class Utils
    def self.latest(arr)
      (arr.select { |x| valid_from(x) }.sort_by { |x| valid_from(x) } + arr.reject { |x| valid_from(x) }).last
    end

    def self.vertify_in(arr, value)
      raise "Could not find #{value} in #{arr}" if value && arr.exclude?(value)
      value
    end

    def self.period_valid?(period)
      period['gyldigTil'].blank?
    end

    def self.only(arr)
      raise "Error: #{arr} contains more than 1 element" if arr.size > 1
      arr.first
    end

    private

    def self.valid_from(value)
      date_str = value.try(:[], 'periode').try(:[], 'gyldigFra')
      Date.parse(date_str) if date_str.present?
    end
  end
end
