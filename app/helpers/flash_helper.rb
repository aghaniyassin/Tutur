module FlashHelper

  def flash_message(category, message)
    flash[category] ||= []
    flash[category] << message
  end

  def clear_flash
    flash.discard
  end
end
