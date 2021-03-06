module ApplicationHelper
  
  def full_title(page_title)
    base_title = "Box Tracking"    
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "#{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction), {class: css_class}
  end
end
