module ApplicationHelper

  BOOTSTRAP_FLASH_MAPPINGS = {
    success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
  }

  def bootstrap_class_for(flash_type)
    p flash_type
    BOOTSTRAP_FLASH_MAPPINGS.fetch(flash_type.to_sym, flash_type.to_s)
  end

end
