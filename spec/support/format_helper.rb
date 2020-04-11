# frozen_string_literal: true

module FormatHelper
  def formatted_date(date)
    Time.zone.at(date.to_datetime).strftime('%FT%T')
  end
end
