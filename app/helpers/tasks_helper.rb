module TasksHelper
  def priority_badge(task)
    css_class = case task.priority
    when "high"   then "badge bg-danger"
    when "medium" then "badge bg-warning text-dark"
    when "low"    then "badge bg-success"
    else "badge bg-secondary"
    end

    content_tag(:span, task.priority&.titleize || "None", class: css_class)
  end
end
