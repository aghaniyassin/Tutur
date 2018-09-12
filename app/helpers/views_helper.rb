module ViewsHelper

  def datetime_humanize(date)
    date.strftime("%b %d, %Y")
  end

  def bootstrap_badge(badge)
    case badge when nil
      'warning'
    when true
      'success'
    when false
      'danger'
    end
  end

  def enums_to_select_option(enums, first_option = nil)
    options = enums.map {|e| [e.first.humanize, e.first]}
    first_option ? [[first_option, nil], *options] : options
  end

  def choices_for_select_options(params = {})
    { disabled: 'All', selected: (params[:selected] || 'All') }
  end

  def years_select_option
    (2000..Time.now.year).to_a.reverse
  end
end
