class DateUtil
  def self.parse(from, str)
    return Time.parse(str) if str =~ /^\d\d\d\d-\d?\d-\d?\d$/

    return $1.to_i.business_days.after(from) if str =~ /(\d+) bus((iness)? days?)?/i

    return from + ChronicDuration.parse(str)
  rescue => ex
    raise "Unrecognized date #{str} - #{ex}"
  end
end