module FormHelper

  def control_group_for(object, method, &block)
    control_group_class = 'controlgroup'
    control_group_class += ' error' if object.errors[method].any?
    content_tag(:div, class: control_group_class, &block)
  end

  def error_message_for(object, method)
    return unless object.errors[method].any?
    content_tag(:span, object.errors[method].to_sentence, class: 'error_message')
  end
end
