module ViewsHelper
  def datetime_humanize(date)
    date.strftime("%b %d, %Y")
  end
end
