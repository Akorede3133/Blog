module ApplicationHelper
  def slice_text(text)
    text.length > 50 ? "#{text[0, 50]}..." : text
  end
end
