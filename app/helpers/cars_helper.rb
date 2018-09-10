module CarsHelper

  def enums_to_select_option(enums, params = nil)
    options = enums.map {|e| [e.first.humanize, e.first]}
    params ? placeholder_option(params[:placeholder], options) : options
  end

  def placeholder_option(placeholder, options)
    options_for_select [placeholder, *options],
                       selected: placeholder, disabled: placeholder
  end

  def years_select_option(params = nil)
    options = (2000..Time.now.year).to_a.reverse
    params ? placeholder_option(params[:placeholder], options) : options
  end

end
