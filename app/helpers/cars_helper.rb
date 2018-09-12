module CarsHelper

  def enums_to_select_option(enums)
    options = enums.map {|e| [e.first.humanize, e.first]}
    [['All', nil], *options]
  end

  def choices_for_select_options(params = {})
    { disabled: 'All', selected: (params[:selected] || 'Choose') }
  end

  def years_select_option
    (2000..Time.now.year).to_a.reverse
  end
end
