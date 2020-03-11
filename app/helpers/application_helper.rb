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

  def notification_count_badge(count)
    content_tag(:span, count, id: 'notification-count',
                              class: 'badge badge-danger')
  end

  def notification_link(notification)
    text = icon('far', notification.icon) + " #{notification.title} " +
           content_tag(:small, "#{time_ago_in_words(notification.created_at)} ago", class: 'text-muted font-italic')

    link_to(
      text,
      mark_as_read_notification_path(notification),
      method: :post, class: 'dropdown-item'
    )
  end
end
