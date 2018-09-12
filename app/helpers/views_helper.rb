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
end
