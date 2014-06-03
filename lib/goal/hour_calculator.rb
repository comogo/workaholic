module Goal
  class HourCalculator
    def initialize(start_day)
      @start_day = start_day
    end

    def total_days_until(date = Date.today)
      total = 0
      month = Date.today.month
      year  = Date.today.year
      aux_date = date

      while (aux_date.day < start_day && aux_date.month == month) || (aux_date.day > start_day && aux_date.month == month -1) do
        total += 1 unless aux_date.saturday? || aux_date.sunday?
        aux_date  -= 1
      end

      aux_date = date

      while (aux_date.day > start_day && aux_date.month == month) || (aux_date.day < start_day && aux_date.month == month + 1) do
        total += 1 unless aux_date.saturday? || aux_date.sunday?
        aux_date  -= 1
      end

      total
    end

    def estimated_for(goal)
      current_days = total_days_until
      total_days   = total_days_until(end_of_period)

      hours_per_day = goal.to_f / total_days.to_f

      current_days * hours_per_day
    end

    def hour_rate(hours_until_now)
      return 0 unless total_days_until > 0

      hours_until_now.to_f / total_days_until.to_f
    end

    def rate_to_goal(goal, hours_until_now)
      return 0 unless days_left > 0

      (goal - hours_until_now) / days_left
    end

    def days_left
      total_days_until(end_of_period) - total_days_until + 1
    end

    private

    attr_reader :start_day

    def end_of_period
      Date.new(Date.today.year, Date.today.month, start_day) + 30
    end
  end
end
