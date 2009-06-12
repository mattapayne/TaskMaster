module TaskMaster
  module DateHelpers
    def convert_date(date, format="%Y-%m-%dT%H:%M:%S")
      if date.is_a?(String)
        date = DateTime.parse(date)
      end
      date.strftime(format)
    end
  end
end