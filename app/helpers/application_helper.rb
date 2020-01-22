module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Fakebook'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def bootstrap_alert_class(message_type)
    case message_type
    when 'notice'
      'alert-success'
    when 'alert'
      'alert-danger'
    else
      "alert alert-#{message_type}"
    end
  end
end
