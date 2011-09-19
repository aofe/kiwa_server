module UncertainDate
  def method_missing(method, *args, &block)
    if method.to_s.ends_with? 'date'
      name = method.to_s.gsub('date', '')
      parse_date(send("#{name}year"), send("#{name}month"), send("#{name}day"))
    else
      super
    end
  end      

  private

  def parse_date(year, month, day)
    return nil if year.blank? || year == 0
    date = [year]
    date << month unless month.blank? or month == 0
    date << day unless day.blank? or day == 0
    date = date.join('/')
    Date.parse(date)
  rescue ArgumentError
    return nil
  end
end