module ApplicationHelper
  def html_safe_newline(str)
    sanitize str&.gsub(/\r\n|\n|\r/, '<br>'), tags: %w[br]
  end
end
