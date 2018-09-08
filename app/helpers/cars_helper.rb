module CarsHelper
  def enums_to_select_option(enums)
    enums.map {|e| [e.first.humanize, e.first]}
  end

  def years_select_option
    (2000..Time.now.year).to_a.reverse
  end
end
