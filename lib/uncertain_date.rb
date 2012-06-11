module UncertainDate
  class Date
    attr_accessor :has_month, :has_day

    def initialize(year, month, day)
      self.has_month = month.to_i != 0
      month = 1 unless has_month

      self.has_day = day.to_i != 0
      day = 1 unless has_day

      @date = ::Date.new(year, month, day)
    end

    def method_missing(*attr)
      @date.send(*attr)
    end

    def to_s
      if has_day
        strftime("%Y-%m-%d")
      elsif has_month
        strftime("%Y-%m")
      else
        strftime("%Y")
      end
    end
  end

  def method_missing(method, *args, &block)
    if method.to_s.ends_with? 'date'
      name = method.to_s.gsub('date', '')
      Date.new(send("#{name}year"), send("#{name}month"), send("#{name}day")) if send("#{name}year").to_i != 0
    else
      super
    end
  end
end